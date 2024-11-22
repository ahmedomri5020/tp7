package org.isetn;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;

import org.isetn.entities.ClassMat;
import org.isetn.entities.Classe;
import org.isetn.entities.Etudiant;
import org.isetn.entities.Formation;
import org.isetn.entities.Matiere;
import org.isetn.entities.User;
import org.isetn.repository.ClasseRepository;
import org.isetn.repository.ClassMatRepository;
import org.isetn.repository.EtudiantRepository;
import org.isetn.repository.FormationRepository;
import org.isetn.repository.MatiereRepository;
import org.isetn.repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.data.rest.core.config.RepositoryRestConfiguration;

@SpringBootApplication
public class ScolA7Application implements CommandLineRunner {
	@Autowired
	private FormationRepository formationRepository;

	@Autowired
	private ClasseRepository classeRepository;
	
	@Autowired
	private MatiereRepository matiereRepository;

	@Autowired
	private ClassMatRepository classMatRepository;  
	
	@Autowired
	private EtudiantRepository etudiantRepository;

	@Autowired
	private UserRepository userRepository;
	
	@Autowired
	private RepositoryRestConfiguration repositoryRestConfiguration;

	public static void main(String[] args) {
		SpringApplication.run(ScolA7Application.class, args);
	}

	@Override
	public void run(String... args) throws Exception {
		//Etudiant et = new Etudiant(null, "Ali", "Ben Ali", new Date());
		//etudiantRepository.save(et);
		//ou
		Formation f1 = formationRepository.save(new Formation(null,"Oracle",100,null));
		Formation f2 = formationRepository.save(new Formation(null,"J2EE",10,null));
		Formation f3 = formationRepository.save(new Formation(null,"Angular",120,null));
		 
		// Création de matières
        Matiere matiere1 = new Matiere();
        matiere1.setIntMat("Mathématiques");
        matiere1.setDescription("Cours de mathématiques");

        Matiere matiere2 = new Matiere();
        matiere2.setIntMat("Informatique");
        matiere2.setDescription("Cours d'informatique");
        
        Matiere matiere3 = new Matiere();
        matiere3.setIntMat("AFCP");
        matiere3.setDescription("TP Atelier Framework Cross Plateforme");
        
        Matiere m1 = matiereRepository.save(matiere1);
        Matiere m2 = matiereRepository.save(matiere2);
        Matiere m3 = matiereRepository.save(matiere3);
        
		Classe c1 = classeRepository.save(new Classe(null,"DSI31",27,null,Arrays.asList(m1, m2),null));
		Classe c2 = classeRepository.save(new Classe(null,"DSI32",25,null,Arrays.asList(m2, m3),null));
		Classe c3 = classeRepository.save(new Classe(null,"DSI33",20,null,Arrays.asList(m1, m3),null));

		// Création de ClassMat avec les coefficients
        ClassMat classMat1 = new ClassMat();
        classMat1.setMatiere(m1);
        classMat1.setClasse(c1);
        classMat1.setCoefMat(2.0f);
        classMat1.setNbrHS(30.0f);
        
        ClassMat classMat2 = new ClassMat();
        classMat2.setMatiere(m2);
        classMat2.setClasse(c1);
        classMat2.setCoefMat(1.5f);
        classMat2.setNbrHS(20.0f);
        
        ClassMat existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c1.getCodClass(), m1.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(1.5f);
            existingClassMat.setNbrHS(20.0f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c1.getCodClass(), m2.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(2f);
            existingClassMat.setNbrHS(30.0f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        
        existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c2.getCodClass(), m3.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(2f);
            existingClassMat.setNbrHS(22.5f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c2.getCodClass(), m2.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(2f);
            existingClassMat.setNbrHS(45.0f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        
        existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c3.getCodClass(), m1.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(2f);
            existingClassMat.setNbrHS(22.5f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        existingClassMat = classMatRepository.findByClasseCodClassAndMatiereCodMat(c3.getCodClass(), m3.getCodMat());
        if (existingClassMat != null) {
            // Mettez à jour les valeurs
            existingClassMat.setCoefMat(3f);
            existingClassMat.setNbrHS(22.5f);
            // Utilisez save pour mettre à jour l'enregistrement
            classMatRepository.save(existingClassMat);
        }
        
		//ClassMat cm1 = classMatRepository.save(classMat1);
        //ClassMat cm2 = classMatRepository.save(classMat2);
		User u1 = userRepository.save(new User(null,"admin@gmail.com","admin123456"));
		SimpleDateFormat fdate = new SimpleDateFormat("dd-MM-yyyy"); 
		//new SimpleDateFormat("yyyy-mm-dd").parse("2020-01-01")
		etudiantRepository.save(new Etudiant(null, "Ali", "Ben Ali", fdate.parse("10-03-2021"),f1,c1));
		etudiantRepository.save(new Etudiant(null, "Mohamed", "Ben Mohamed", fdate.parse("1-04-2010"),f1,c1));
		etudiantRepository.save(new Etudiant(null, "Amin", "Ben Mahmoud", fdate.parse("19-07-2015"),f2,c1));
		etudiantRepository.save(new Etudiant(null, "Samia", "Ben Ahmed", fdate.parse("26-10-2014"),f3,c1));
		etudiantRepository.save(new Etudiant(null, "Foulen", "Ben Foulen1", fdate.parse("11-02-2018"),f3,c2));
		etudiantRepository.save(new Etudiant(null, "Foulen", "Ben Foulen2", new Date(),f3,c3));
	}
}
