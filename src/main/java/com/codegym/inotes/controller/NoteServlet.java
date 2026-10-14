package com.codegym.inotes.controller;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;
import com.codegym.inotes.service.NoteManagement;
import com.codegym.inotes.strategy.NoteDBStrategy;
import com.codegym.inotes.strategy.NoteFileStrategy;
import com.codegym.inotes.strategy.NoteStrategy;

import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

/**
 * Controller Servlet dieu phoi toan bo luong nghiep vu cua ung dung iNotes.
 * Su dung mau Strategy Pattern thong qua NoteManagement de truy xuat du lieu.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
@WebServlet(name = "NoteServlet", urlPatterns = {"/notes", ""})
public class NoteServlet extends HttpServlet {

    private NoteManagement noteManagement;
    private NoteStrategy dbStrategy;
    private NoteStrategy fileStrategy;

    @Override
    public void init() throws ServletException {
        super.init();
        dbStrategy = new NoteDBStrategy();
        fileStrategy = new NoteFileStrategy();

        // Mac dinh khoi dong voi chien luoc MySQL Database.
        // Neu CSDL MySQL chua chay, tu dong fallback sang File de dam bao trai nghiem nguoi dung.
        try {
            List<Note> testNotes = dbStrategy.findAll();
            noteManagement = new NoteManagement(dbStrategy);
            System.out.println("iNotes khoi dong voi chien luoc: MySQL Database");
        } catch (Exception e) {
            System.out.println("Khong the ket noi MySQL, tu dong chuyen sang chien luoc: Text/CSV File");
            noteManagement = new NoteManagement(fileStrategy);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                showCreateForm(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteNote(request, response);
                break;
            case "view":
                viewNote(request, response);
                break;
            case "search":
                searchNotes(request, response);
                break;
            case "switch-strategy":
                switchStrategy(request, response);
                break;
            case "list":
            default:
                listNotes(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "create":
                insertNote(request, response);
                break;
            case "edit":
                updateNote(request, response);
                break;
            default:
                listNotes(request, response);
                break;
        }
    }

    private void listNotes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Note> notes = noteManagement.getAllNotes();
        request.setAttribute("notes", notes);
        attachStrategyInfo(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/note/list.jsp");
        dispatcher.forward(request, response);
    }

    private void showCreateForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<NoteType> noteTypes = noteManagement.getAllNoteTypes();
        request.setAttribute("noteTypes", noteTypes);
        attachStrategyInfo(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/note/create.jsp");
        dispatcher.forward(request, response);
    }

    private void insertNote(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int typeId = 1;
        try {
            typeId = Integer.parseInt(request.getParameter("typeId"));
        } catch (NumberFormatException ignored) {
        }

        noteManagement.addNote(title, content, typeId);
        response.sendRedirect(request.getContextPath() + "/notes?message=created");
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Note note = noteManagement.getNoteById(id);
        List<NoteType> noteTypes = noteManagement.getAllNoteTypes();

        request.setAttribute("note", note);
        request.setAttribute("noteTypes", noteTypes);
        attachStrategyInfo(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/note/edit.jsp");
        dispatcher.forward(request, response);
    }

    private void updateNote(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        String title = request.getParameter("title");
        String content = request.getParameter("content");
        int typeId = Integer.parseInt(request.getParameter("typeId"));

        noteManagement.updateNote(id, title, content, typeId);
        response.sendRedirect(request.getContextPath() + "/notes?message=updated");
    }

    private void deleteNote(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        noteManagement.deleteNote(id);
        response.sendRedirect(request.getContextPath() + "/notes?message=deleted");
    }

    private void viewNote(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        int id = Integer.parseInt(request.getParameter("id"));
        Note note = noteManagement.getNoteById(id);
        request.setAttribute("note", note);
        attachStrategyInfo(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/note/view.jsp");
        dispatcher.forward(request, response);
    }

    private void searchNotes(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String keyword = request.getParameter("keyword");
        List<Note> notes = noteManagement.searchNotes(keyword);
        request.setAttribute("notes", notes);
        request.setAttribute("keyword", keyword);
        attachStrategyInfo(request);

        RequestDispatcher dispatcher = request.getRequestDispatcher("/WEB-INF/views/note/list.jsp");
        dispatcher.forward(request, response);
    }

    private void switchStrategy(HttpServletRequest request, HttpServletResponse response)
            throws IOException {
        String type = request.getParameter("type");
        if ("FILE".equalsIgnoreCase(type)) {
            noteManagement.setStrategy(fileStrategy);
        } else {
            noteManagement.setStrategy(dbStrategy);
        }
        response.sendRedirect(request.getContextPath() + "/notes?message=strategy_switched");
    }

    private void attachStrategyInfo(HttpServletRequest request) {
        String currentStrategyName = noteManagement.getStrategyName();
        boolean isDB = "MySQL Database".equalsIgnoreCase(currentStrategyName);
        request.setAttribute("currentStrategyName", currentStrategyName);
        request.setAttribute("isDB", isDB);
    }
}
