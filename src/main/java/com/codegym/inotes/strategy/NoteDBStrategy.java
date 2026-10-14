package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

/**
 * Chien luoc luu tru ghi chu tren Co so du lieu MySQL thong qua JDBC.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class NoteDBStrategy implements NoteStrategy {

    private String jdbcURL = "jdbc:mysql://localhost:3306/inotes_db?useSSL=false&serverTimezone=UTC&allowPublicKeyRetrieval=true&useUnicode=true&characterEncoding=UTF-8";
    private String jdbcUsername = "root";
    private String jdbcPassword = "password";

    private static final String SELECT_ALL_NOTES =
            "SELECT n.id, n.title, n.content, n.type_id, n.created_at, t.name AS type_name " +
            "FROM notes n LEFT JOIN note_type t ON n.type_id = t.id ORDER BY n.id DESC";

    private static final String SELECT_NOTE_BY_ID =
            "SELECT n.id, n.title, n.content, n.type_id, n.created_at, t.name AS type_name " +
            "FROM notes n LEFT JOIN note_type t ON n.type_id = t.id WHERE n.id = ?";

    private static final String INSERT_NOTE =
            "INSERT INTO notes (title, content, type_id) VALUES (?, ?, ?)";

    private static final String UPDATE_NOTE =
            "UPDATE notes SET title = ?, content = ?, type_id = ? WHERE id = ?";

    private static final String DELETE_NOTE =
            "DELETE FROM notes WHERE id = ?";

    private static final String SEARCH_NOTES =
            "SELECT n.id, n.title, n.content, n.type_id, n.created_at, t.name AS type_name " +
            "FROM notes n LEFT JOIN note_type t ON n.type_id = t.id " +
            "WHERE n.title LIKE ? OR n.content LIKE ? ORDER BY n.id DESC";

    private static final String SELECT_ALL_TYPES =
            "SELECT id, name, description FROM note_type ORDER BY id ASC";

    private static final String SELECT_TYPE_BY_ID =
            "SELECT id, name, description FROM note_type WHERE id = ?";

    public NoteDBStrategy() {
        String envUser = System.getenv("DB_USER");
        String envPass = System.getenv("DB_PASSWORD");
        String envUrl = System.getenv("DB_URL");
        if (envUser != null && !envUser.isEmpty()) this.jdbcUsername = envUser;
        if (envPass != null) this.jdbcPassword = envPass;
        if (envUrl != null && !envUrl.isEmpty()) this.jdbcURL = envUrl;
    }

    public NoteDBStrategy(String jdbcURL, String jdbcUsername, String jdbcPassword) {
        this.jdbcURL = jdbcURL;
        this.jdbcUsername = jdbcUsername;
        this.jdbcPassword = jdbcPassword;
    }

    protected Connection getConnection() throws SQLException {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            e.printStackTrace();
        }
        return DriverManager.getConnection(jdbcURL, jdbcUsername, jdbcPassword);
    }

    @Override
    public String getStrategyName() {
        return "MySQL Database";
    }

    @Override
    public void save(Note note) {
        if (note == null) return;
        if (note.getId() > 0) {
            update(note);
        } else {
            insert(note);
        }
    }

    private void insert(Note note) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(INSERT_NOTE, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, note.getTitle());
            preparedStatement.setString(2, note.getContent());
            preparedStatement.setInt(3, note.getTypeId());
            preparedStatement.executeUpdate();

            try (ResultSet rs = preparedStatement.getGeneratedKeys()) {
                if (rs.next()) {
                    note.setId(rs.getInt(1));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    private void update(Note note) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(UPDATE_NOTE)) {
            preparedStatement.setString(1, note.getTitle());
            preparedStatement.setString(2, note.getContent());
            preparedStatement.setInt(3, note.getTypeId());
            preparedStatement.setInt(4, note.getId());
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public void delete(int id) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(DELETE_NOTE)) {
            preparedStatement.setInt(1, id);
            preparedStatement.executeUpdate();
        } catch (SQLException e) {
            printSQLException(e);
        }
    }

    @Override
    public List<Note> findAll() {
        List<Note> notes = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_NOTES);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                Note note = mapResultSetToNote(rs);
                notes.add(note);
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return notes;
    }

    @Override
    public Note findById(int id) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_NOTE_BY_ID)) {
            preparedStatement.setInt(1, id);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return mapResultSetToNote(rs);
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    @Override
    public List<Note> search(String keyword) {
        List<Note> notes = new ArrayList<>();
        String searchPattern = "%" + (keyword != null ? keyword.trim() : "") + "%";
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SEARCH_NOTES)) {
            preparedStatement.setString(1, searchPattern);
            preparedStatement.setString(2, searchPattern);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                while (rs.next()) {
                    notes.add(mapResultSetToNote(rs));
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return notes;
    }

    @Override
    public List<NoteType> findAllNoteTypes() {
        List<NoteType> types = new ArrayList<>();
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_ALL_TYPES);
             ResultSet rs = preparedStatement.executeQuery()) {
            while (rs.next()) {
                types.add(new NoteType(
                        rs.getInt("id"),
                        rs.getString("name"),
                        rs.getString("description")
                ));
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return types;
    }

    @Override
    public NoteType findNoteTypeById(int typeId) {
        try (Connection connection = getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SELECT_TYPE_BY_ID)) {
            preparedStatement.setInt(1, typeId);
            try (ResultSet rs = preparedStatement.executeQuery()) {
                if (rs.next()) {
                    return new NoteType(
                            rs.getInt("id"),
                            rs.getString("name"),
                            rs.getString("description")
                    );
                }
            }
        } catch (SQLException e) {
            printSQLException(e);
        }
        return null;
    }

    private Note mapResultSetToNote(ResultSet rs) throws SQLException {
        Note note = new Note(
                rs.getInt("id"),
                rs.getString("title"),
                rs.getString("content"),
                rs.getInt("type_id"),
                rs.getString("type_name")
        );
        Timestamp createdAt = rs.getTimestamp("created_at");
        if (createdAt != null) {
            note.setCreatedAt(createdAt.toString());
        }
        return note;
    }

    private void printSQLException(SQLException ex) {
        for (Throwable e : ex) {
            if (e instanceof SQLException) {
                System.err.println("SQLState: " + ((SQLException) e).getSQLState());
                System.err.println("Error Code: " + ((SQLException) e).getErrorCode());
                System.err.println("Message: " + e.getMessage());
                Throwable t = ex.getCause();
                while (t != null) {
                    System.err.println("Cause: " + t);
                    t = t.getCause();
                }
            }
        }
    }
}
