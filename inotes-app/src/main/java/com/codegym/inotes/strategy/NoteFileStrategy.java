package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;

import java.io.*;
import java.nio.charset.StandardCharsets;
import java.util.*;

/**
 * Chien luoc luu tru ghi chu vao tap tin van ban (File txt/csv) voi dinh dang phan tach:
 * id|title|content|typeId
 *
 * Ho tro tao file tu dong, khoi tao du lieu mau va dong bo thread-safe.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class NoteFileStrategy implements NoteStrategy {

    private final String filePath;
    private final String typeFilePath;

    public NoteFileStrategy() {
        String baseDir = System.getProperty("user.home") + File.separator + "inotes_data";
        File dir = new File(baseDir);
        if (!dir.exists()) {
            dir.mkdirs();
        }
        this.filePath = baseDir + File.separator + "notes.txt";
        this.typeFilePath = baseDir + File.separator + "note_types.txt";
        initDefaultFiles();
    }

    public NoteFileStrategy(String filePath, String typeFilePath) {
        this.filePath = filePath;
        this.typeFilePath = typeFilePath;
        initDefaultFiles();
    }

    private synchronized void initDefaultFiles() {
        File tFile = new File(typeFilePath);
        if (!tFile.exists() || tFile.length() == 0) {
            List<String> defaultTypes = Arrays.asList(
                    "1|Cá nhân|Ghi chú sinh hoạt, sở thích và kế hoạch cá nhân",
                    "2|Công việc|Nhiệm vụ, dự án, cuộc họp và deadline công việc",
                    "3|Học tập|Kiến thức lập trình, bài tập và tài liệu nghiên cứu"
            );
            writeFileLines(tFile, defaultTypes);
        }

        File nFile = new File(filePath);
        if (!nFile.exists() || nFile.length() == 0) {
            List<String> defaultNotes = Arrays.asList(
                    "1|Họp giao ban đầu tuần (File)|Báo cáo tiến độ module Strategy Pattern và tổng kết sprint trước|2",
                    "2|Ôn tập Design Pattern Servlet (File)|Nghiên cứu áp dụng Strategy Pattern, Singleton và Factory trong Java Web MVC|3",
                    "3|Lên lịch tập thể dục buổi sáng (File)|Chạy bộ 30 phút và tập cardio nhẹ nhàng lúc 6h00|1"
            );
            writeFileLines(nFile, defaultNotes);
        }
    }

    @Override
    public String getStrategyName() {
        return "Text/CSV File";
    }

    @Override
    public synchronized void save(Note note) {
        if (note == null) return;
        List<Note> notes = readAllNotesFromFile();

        if (note.getId() > 0) {
            // Cap nhat ghi chu da co
            boolean found = false;
            for (int i = 0; i < notes.size(); i++) {
                if (notes.get(i).getId() == note.getId()) {
                    notes.set(i, note);
                    found = true;
                    break;
                }
            }
            if (!found) {
                notes.add(note);
            }
        } else {
            // Them moi ghi chu va tu dong sinh ID
            int maxId = 0;
            for (Note n : notes) {
                if (n.getId() > maxId) {
                    maxId = n.getId();
                }
            }
            note.setId(maxId + 1);
            notes.add(0, note); // Dua len dau danh sach
        }

        writeAllNotesToFile(notes);
    }

    @Override
    public synchronized void delete(int id) {
        List<Note> notes = readAllNotesFromFile();
        notes.removeIf(n -> n.getId() == id);
        writeAllNotesToFile(notes);
    }

    @Override
    public synchronized List<Note> findAll() {
        return readAllNotesFromFile();
    }

    @Override
    public synchronized Note findById(int id) {
        List<Note> notes = readAllNotesFromFile();
        for (Note n : notes) {
            if (n.getId() == id) {
                return n;
            }
        }
        return null;
    }

    @Override
    public synchronized List<Note> search(String keyword) {
        List<Note> notes = readAllNotesFromFile();
        if (keyword == null || keyword.trim().isEmpty()) {
            return notes;
        }
        String lowerKw = keyword.trim().toLowerCase();
        List<Note> results = new ArrayList<>();
        for (Note n : notes) {
            boolean matchTitle = n.getTitle() != null && n.getTitle().toLowerCase().contains(lowerKw);
            boolean matchContent = n.getContent() != null && n.getContent().toLowerCase().contains(lowerKw);
            if (matchTitle || matchContent) {
                results.add(n);
            }
        }
        return results;
    }

    @Override
    public synchronized List<NoteType> findAllNoteTypes() {
        List<NoteType> types = new ArrayList<>();
        File file = new File(typeFilePath);
        if (!file.exists()) return types;

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("#")) continue;
                String[] parts = line.split("\\|", -1);
                if (parts.length >= 2) {
                    int id = Integer.parseInt(parts[0].trim());
                    String name = parts[1].trim();
                    String description = parts.length > 2 ? parts[2].trim() : "";
                    types.add(new NoteType(id, name, description));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return types;
    }

    @Override
    public NoteType findNoteTypeById(int typeId) {
        List<NoteType> types = findAllNoteTypes();
        for (NoteType t : types) {
            if (t.getId() == typeId) {
                return t;
            }
        }
        return null;
    }

    private List<Note> readAllNotesFromFile() {
        List<Note> notes = new ArrayList<>();
        File file = new File(filePath);
        if (!file.exists()) return notes;

        Map<Integer, String> typeMap = buildTypeMap();

        try (BufferedReader reader = new BufferedReader(new InputStreamReader(new FileInputStream(file), StandardCharsets.UTF_8))) {
            String line;
            while ((line = reader.readLine()) != null) {
                line = line.trim();
                if (line.isEmpty() || line.startsWith("#")) continue;

                // Dinh dang: id|title|content|typeId
                String[] parts = line.split("\\|", -1);
                if (parts.length >= 4) {
                    int id = Integer.parseInt(parts[0].trim());
                    String title = unescapeDelimiter(parts[1]);
                    String content = unescapeDelimiter(parts[2]);
                    int typeId = Integer.parseInt(parts[3].trim());

                    String typeName = typeMap.getOrDefault(typeId, "Khác");
                    Note note = new Note(id, title, content, typeId, typeName);
                    notes.add(note);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return notes;
    }

    private void writeAllNotesToFile(List<Note> notes) {
        File file = new File(filePath);
        try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, false), StandardCharsets.UTF_8))) {
            for (Note n : notes) {
                String line = String.format("%d|%s|%s|%d",
                        n.getId(),
                        escapeDelimiter(n.getTitle()),
                        escapeDelimiter(n.getContent()),
                        n.getTypeId());
                writer.write(line);
                writer.newLine();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private void writeFileLines(File file, List<String> lines) {
        try {
            if (file.getParentFile() != null && !file.getParentFile().exists()) {
                file.getParentFile().mkdirs();
            }
            try (BufferedWriter writer = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file, false), StandardCharsets.UTF_8))) {
                for (String line : lines) {
                    writer.write(line);
                    writer.newLine();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    private Map<Integer, String> buildTypeMap() {
        Map<Integer, String> map = new HashMap<>();
        List<NoteType> types = findAllNoteTypes();
        for (NoteType t : types) {
            map.put(t.getId(), t.getName());
        }
        return map;
    }

    private String escapeDelimiter(String str) {
        if (str == null) return "";
        return str.replace("\\", "\\\\")
                  .replace("|", "\\p")
                  .replace("\r", "")
                  .replace("\n", "\\n");
    }

    private String unescapeDelimiter(String str) {
        if (str == null) return "";
        return str.replace("\\n", "\n")
                  .replace("\\p", "|")
                  .replace("\\\\", "\\");
    }
}
