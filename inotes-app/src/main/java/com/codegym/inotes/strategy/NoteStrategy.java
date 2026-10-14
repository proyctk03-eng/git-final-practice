package com.codegym.inotes.strategy;

import com.codegym.inotes.model.Note;
import com.codegym.inotes.model.NoteType;
import java.util.List;

/**
 * Interface NoteStrategy trong mau thiet ke Strategy Pattern.
 * Dinh nghia hop dong chuan cho cac chien luoc luu tru ghi chu (Database hoac File).
 *
 * Author: Nguyen Tuan Dat (proyctk03@gmail.com)
 */
public interface NoteStrategy {

    /**
     * Lay ten chien luoc luu tru hien tai.
     *
     * @return Ten chien luoc (vi du: "MySQL Database" hoac "Text/CSV File")
     */
    String getStrategyName();

    /**
     * Luu ghi chu moi hoac cap nhat ghi chu hien co.
     *
     * @param note Doi tuong ghi chu can luu
     */
    void save(Note note);

    /**
     * Xoa ghi chu theo ma ID.
     *
     * @param id Ma dinh danh ghi chu
     */
    void delete(int id);

    /**
     * Lay toan bo danh sach ghi chu.
     *
     * @return Danh sach cac ghi chu kem ten the loai
     */
    List<Note> findAll();

    /**
     * Tim kiem ghi chu theo ma ID.
     *
     * @param id Ma dinh danh ghi chu
     * @return Doi tuong Note hoac null neu khong tim thay
     */
    Note findById(int id);

    /**
     * Tim kiem ghi chu theo tu khoa xuat hien trong tieu de hoac noi dung.
     *
     * @param keyword Tu khoa tim kiem
     * @return Danh sach ghi chu phu hop
     */
    List<Note> search(String keyword);

    /**
     * Lay toan bo danh muc phan loai ghi chu.
     *
     * @return Danh sach NoteType
     */
    List<NoteType> findAllNoteTypes();

    /**
     * Tim loai ghi chu theo ID.
     *
     * @param typeId Ma loai ghi chu
     * @return Doi tuong NoteType
     */
    NoteType findNoteTypeById(int typeId);
}
