package com.auliarazak.matakuliah.repository;


import com.auliarazak.matakuliah.entity.Matakuliah;
import java.util.Optional;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

/**
 *
 * @author Asus
 */
@Repository
public interface MatakuliahRepository extends JpaRepository<Matakuliah, Long> {

    public Optional<Matakuliah> findMatakuliahByNama(String nama);

    public Optional<Matakuliah> findMatakuliahByKode(String kode);

   
}