package org.isetn.repository;

import org.isetn.entities.ClassMat;

import org.springframework.data.jpa.repository.JpaRepository;


public interface ClassMatRepository extends JpaRepository<ClassMat, Long> {


	ClassMat findByClasseCodClassAndMatiereCodMat(Long codClass, Long codMat);
	
}
