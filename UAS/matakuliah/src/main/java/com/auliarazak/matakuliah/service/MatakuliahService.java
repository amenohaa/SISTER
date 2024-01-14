/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.auliarazak.matakuliah.service;

import com.auliarazak.matakuliah.entity.Matakuliah;
import com.auliarazak.matakuliah.repository.MatakuliahRepository;
import jakarta.transaction.Transactional;
import java.time.LocalDate;
import java.util.List;
import java.util.Objects;
import java.util.Optional;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *
 * @author Asus
 */
@Service
public class MatakuliahService {
    
    @Autowired
    private MatakuliahRepository matakuliahRepository;
    
    public List<Matakuliah> getAll() {
        return matakuliahRepository.findAll();
    }
    
    public Matakuliah getMatakuliahById(Long id) {
        Optional<Matakuliah> matakuliahOptional = matakuliahRepository.findById(id);
        return matakuliahRepository.findById(id).get();
    }
    
    public void insert(Matakuliah matakuliah) {
//        Optional<Matakuliah> matakuliahOptional = matakuliahRepository.findMatakuliahByNama(matakuliah.getNama());
//        Optional<Matakuliah> matakuliahOptionalkode = matakuliahRepository.findMatakuliahByKode(matakuliah.getKode());
//        if (matakuliahOptional.isPresent()) {
//            throw new IllegalStateException("Nama Matakuliah ini sudah ada");
//        }
//        if (matakuliahOptionalkode.isPresent()) {
//            throw new IllegalStateException("Kode Matakuliah Sudah ada");
//        }
        
        matakuliahRepository.save(matakuliah);
        
    }
    
    public void delete(Long id) {
        matakuliahRepository.deleteById(id);
    }
    
    @Transactional
    public void update(long id, String kode, String nama, Integer sks) {
        Matakuliah matakuliah = matakuliahRepository.findById(id).orElseThrow(() -> new IllegalStateException("Matakuliah Tidak Ada"));
        
        if (nama != null && nama.length() > 0 && !Objects.equals(matakuliah.getNama(), nama)) {
            matakuliah.setNama(nama);
            
        }
        if (kode != null && kode.length() > 0 && !Objects.equals(matakuliah.getKode(), kode)) {
            Optional<Matakuliah> matkulOptionalkode = matakuliahRepository.findMatakuliahByKode(kode);
            if (matkulOptionalkode.isPresent()) {
                throw new IllegalStateException("Kode ini sudah ada");
            }
            matakuliah.setKode(kode);
            
        }
        if (nama != null && nama.length() > 0 && !Objects.equals(matakuliah.getNama(), nama)) {
            Optional<Matakuliah> matkulOptionalnama = matakuliahRepository.findMatakuliahByNama(nama);
            if (matkulOptionalnama.isPresent()) {
                throw new IllegalStateException("nama matakuliah sudah ada");
            }
            matakuliah.setNama(nama);
        }

        
        if (sks != null && !Objects.equals(matakuliah.getSks(), sks)) {
            matakuliah.setSks(sks);
            
        }
        
    }
}
