package com.codegym.inotes.model;

import com.codegym.inotes.service.NoteManagement;
import java.io.Serializable;

/**
 * Lop thuc the Note chua cac thuoc tinh va phuong thuc quan ly ghi chu.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class Note implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String title;
    private String content;
    private int typeId;
    private String typeName;
    private String createdAt;

    public Note() {
    }

    public Note(int id, String title, String content, int typeId) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.typeId = typeId;
    }

    public Note(int id, String title, String content, int typeId, String typeName) {
        this.id = id;
        this.title = title;
        this.content = content;
        this.typeId = typeId;
        this.typeName = typeName;
    }

    public Note(String title, String content, int typeId) {
        this.title = title;
        this.content = content;
        this.typeId = typeId;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getTypeId() {
        return typeId;
    }

    public void setTypeId(int typeId) {
        this.typeId = typeId;
    }

    public String getTypeName() {
        return typeName;
    }

    public void setTypeName(String typeName) {
        this.typeName = typeName;
    }

    public String getCreatedAt() {
        return createdAt;
    }

    public void setCreatedAt(String createdAt) {
        this.createdAt = createdAt;
    }

    /**
     * Luu hoac cap nhat ghi chu hien tai vao he thong luu tru thong qua NoteManagement.
     *
     * @param management Doi tuong quan ly NoteManagement
     */
    public void save(NoteManagement management) {
        if (management != null) {
            if (this.id == 0) {
                management.addNote(this.title, this.content, this.typeId);
            } else {
                management.updateNote(this.id, this.title, this.content, this.typeId);
            }
        }
    }

    /**
     * Xoa ghi chu theo ID thong qua NoteManagement.
     *
     * @param management Doi tuong quan ly NoteManagement
     * @param noteId ID ghi chu can xoa
     */
    public static void delete(NoteManagement management, int noteId) {
        if (management != null) {
            management.deleteNote(noteId);
        }
    }

    @Override
    public String toString() {
        return "Note{id=" + id + ", title='" + title + '\'' + ", typeId=" + typeId + ", typeName='" + typeName + '\'' + '}';
    }
}
