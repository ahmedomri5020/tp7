package org.isetn.entities;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;

import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

@Entity
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Classe {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long codClass;
	private String nomClass;
	private int nbreEtud;

	@JsonIgnore
	@OneToMany(mappedBy = "classe", cascade = CascadeType.ALL)
	// @JsonBackReference
	private List<Etudiant> etudiants;

    //@JsonIgnore
	@ManyToMany
	@JoinTable(name = "ClassMat", 
			joinColumns = @JoinColumn(name = "codClass"), 
			inverseJoinColumns = @JoinColumn(name = "codMat"))
	private List<Matiere> matieres= new ArrayList<>();
	
	@JsonIgnore
    @OneToMany(mappedBy = "classe", cascade = CascadeType.ALL)
    private List<ClassMat> classMats= new ArrayList<>();;
	/*
	 * private Float coefMat; private Float nbrHS;
	 */

	/*
	 * @JsonBackReference: This annotation is used on the child side of the
	 * relationship. It indicates that the property should be ignored during
	 * serialization. When the child entity is serialized, the parent entity will be
	 * excluded to break the loop.
	 */
}
/*
 * L'annotation @JsonIgnore est utilisée pour exclure une propriété de la
 * sérialisation et de la désérialisation JSON. Dans votre cas, vous l'avez
 * utilisée sur la propriété classe de la classe "Etudiant". Cela signifie que
 * lorsqu'un objet "Etudiant" est sérialisé en JSON, la propriété classe ne sera
 * pas incluse dans la représentation JSON. Cela peut être utile pour éviter les
 * boucles infinies lors de la sérialisation d'objets imbriqués. D'autre part,
 * l'annotation @JsonManagedReference est utilisée pour indiquer que la
 * propriété annotée est la partie "gérée" de la relation parent-enfant. Dans
 * votre cas, vous l'avez également utilisée sur la propriété classe de la
 * classe "Etudiant". Cela indique à Jackson que la propriété classe est la
 * partie "gérée" de la relation, et elle sera sérialisée normalement lorsque la
 * classe "Etudiant" est sérialisée en JSON.
 * 
 * En résumé, en utilisant @JsonIgnore sur la propriété classe dans la classe
 * "Etudiant", vous excluez cette propriété de la sérialisation JSON. En
 * utilisant @JsonManagedReference sur la même propriété, vous indiquez à
 * Jackson de la traiter normalement lors de la sérialisation JSON. Cette
 * approche est correcte pour gérer la relation parent-enfant entre les classes
 * "Classe" et "Etudiant".
 */
