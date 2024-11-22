package org.isetn.entities;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;

import org.springframework.format.annotation.DateTimeFormat;

import com.fasterxml.jackson.annotation.JsonIgnore;
import com.fasterxml.jackson.annotation.JsonManagedReference;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor

public class Etudiant {
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	private String nom;
	private String prenom;
	@DateTimeFormat(pattern = "dd-MM-yyyy")
	private Date dateNais;
	
    @ManyToOne
    @JsonIgnore
    @JsonManagedReference
	private Formation formation;
	
	@ManyToOne
	//@JsonIgnore
	//@JsonManagedReference
	private Classe classe;
	
	/* @JsonManagedReference: This annotation is used on the parent 
	side of the relationship. It indicates that the property 
	should be serialized as normal. When the parent entity 
	is serialized, the child entity will be included.*/
}
