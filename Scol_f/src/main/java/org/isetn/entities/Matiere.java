package org.isetn.entities;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

import com.fasterxml.jackson.annotation.JsonIgnore;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
@Data
@NoArgsConstructor
@AllArgsConstructor
@Entity
public class Matiere {
	@Id @GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long codMat;
	private String intMat;
	private String  Description;
	
    @JsonIgnore
	@ManyToMany(mappedBy = "matieres")
	    private List<Classe> classes;

	   
}
