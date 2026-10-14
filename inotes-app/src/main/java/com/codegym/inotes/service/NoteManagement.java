package com.codegym.inotes.service;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;
import com.codegym.inotes.strategy.NoteStrategy;

import java.util.List;

/**
 * Lop Context trong mau thiet ke Strategy Pattern.
 * Quan ly nghiep vu ghi chu va cho phep chuyen doi linh hoat tang luu tru (Strategy) luc runtime.
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public class NoteManagement {

    // Thuoc tinh chien luoc luu tru hien tai (Strategy)
    private NoteStrategy strategy;

    public NoteManagement(NoteStrategy strategy) {
        this.strategy = strategy;
    }

    /**
     * Thay doi chien luoc luu tru luc runtime (Pluggable Storage Layer).
     *
     * @param strategy Chien luoc moi (NoteDBStrategy hoac NoteFileStrategy)
     */
    public void setStrategy(NoteStrategy strategy) {
        this.strategy = strategy;
    }

    /**
     * Lay chien luoc luu tru dang kich hoat.
     *
     * @return Doi tuong NoteStrategy
     */
    public NoteStrategy getStrategy() {
        return this.strategy;
    }

    /**
     * Lay ten chien luoc luu tru hien tai.
     *
     * @return Chuoi ten chien luoc
     */
    public String getStrategyName() {
        return strategy != null ? strategy.getStrategyName() : "Unknown";
    }

    /**
     * Tao moi va luu ghi chu vao he thong luu tru.
     *
     * @param title Tieu de ghi chu
     * @param content Noi dung chi tiet
     * @param typeId Ma the loai ghi chu
     */
    public void addNote(String title, String content, int typeId) {
        Note note = new Note(title, content, typeId);
        if (strategy != null) {
            strategy.save(note);
        }
    }

    /**
     * Cap nhat thong tin ghi chu da ton tai.
     *
     * @param id Ma dinh danh ghi chu
     * @param title Tieu de moi
     * @param content Noi dung moi
     * @param typeId Ma the loai moi
     */
    public void updateNote(int id, String title, String content, int typeId) {
        Note note = new Note(id, title, content, typeId);
        if (strategy != null) {
            strategy.save(note);
        }
    }

    /**
     * Xoa bo ghi chu theo ma ID.
     *
     * @param id Ma dinh danh ghi chu can xoa
     */
    public void deleteNote(int id) {
        if (strategy != null) {
            strategy.delete(id);
        }
    }

    /**
     * Tim kiem danh sach ghi chu theo tu khoa xuat hien trong tieu de hoac noi dung.
     *
     * @param keyword Tu khoa tim kiem
     * @return Danh sach ghi chu phu hop
     */
    public List<Note> searchNotes(String keyword) {
        if (strategy != null) {
            return strategy.search(keyword);
        }
        return List.of();
    }

    /**
     * Lay toan bo danh sach ghi chu tu tang luu tru hien tai.
     *
     * @return Danh sach tat ca ghi chu
     */
    public List<Note> getAllNotes() {
        if (strategy != null) {
            return strategy.findAll();
        }
        return List.of();
    }

    /**
     * Lay chi tiet mot ghi chu theo ID.
     *
     * @param id Ma dinh danh
     * @return Ghi chu tim thay hoac null
     */
    public Note getNoteById(int id) {
        if (strategy != null) {
            return strategy.findById(id);
        }
        return null;
    }

    /**
     * Lay toan bo danh sach phan loai ghi chu.
     *
     * @return Danh sach NoteType
     */
    public List<NoteType> getAllNoteTypes() {
        if (strategy != null) {
            return strategy.findAllNoteTypes();
        }
        return List.of();
    }

    /**
     * Lay thong tin loai ghi chu theo ID.
     *
     * @param typeId Ma loai
     * @return Doi tuong NoteType
     */
    public NoteType getNoteTypeById(int typeId) {
        if (strategy != null) {
            return strategy.findNoteTypeById(typeId);
        }
        return null;
    }
}
