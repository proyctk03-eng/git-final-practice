package com.codegym.inotes.model;

import java.io.Serializable;

/**
 * Lop thuc the the hien loai ghi chu (Danh muc).
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class NoteType implements Serializable {
    private static final long serialVersionUID = 1L;

    private int id;
    private String name;
    private String description;

    public NoteType() {
    }

    public NoteType(int id, String name, String description) {
        this.id = id;
        this.name = name;
        this.description = description;
    }

    public NoteType(String name, String description) {
        this.name = name;
        this.description = description;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    @Override
    public String toString() {
        return "NoteType{id=" + id + ", name='" + name + '\'' + ", description='" + description + '\'' + '}';
    }
}
