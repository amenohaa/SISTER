/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.auliarazak.mahasiswa.service;

import com.auliarazak.mahasiswa.entity.Mahasiswa;
import com.auliarazak.mahasiswa.repository.MahasiswaRepository;
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
public class MahasiswaService {

    @Autowired
    private MahasiswaRepository mahasiswaRepository;

    public void insert(Mahasiswa mahasiswa) {
        Optional<Mahasiswa> mhsOptional = mahasiswaRepository.findMahasiswaByEmail(mahasiswa.getEmail());
        if (mhsOptional.isPresent()) {
            throw new IllegalStateException("Email sudah ada");
        }
        mahasiswaRepository.save(mahasiswa);
    }

    public List<Mahasiswa> getAll() {
        return mahasiswaRepository.findAll();
    }

    public Mahasiswa getMahasiswaById(Long id) {
        return mahasiswaRepository.findById(id).get();
    }

    public void delete(Long id) {
        mahasiswaRepository.deleteById(id);
    }
    
    @Transactional
    public void update(Long id, String nama, String email, LocalDate tgllahir) {
        Mahasiswa mahasiswa = mahasiswaRepository.findById(id).orElseThrow(() -> new IllegalStateException("Mahasiswa Tidak Ada"));
        
        if (nama != null && nama.length() > 0 && !Objects.equals(mahasiswa.getNama(), nama)) {
            mahasiswa.setNama(nama);
            
        }
        if (email != null && email.length() > 0 && !Objects.equals(mahasiswa.getEmail(), email)) {
            mahasiswa.setEmail(email);
            
        }
        if (tgllahir != null && !Objects.equals(mahasiswa.getTgllahir(), tgllahir)) {
            mahasiswa.setTgllahir(tgllahir);
            
        }
        
    }

}
