**Machine Ã  vecteur de support: SVM**
  
   **Contexte**
La fraude à la carte bancaire est un sujet complexe et passionnant du point de vue mathématique. Les algorithmes développés doivent être capables de s’adapter tout autant aux spécificités des données de transaction qu’à celles des fraudes.Nous présenterons par la suite le SVM pour la detection de farude sur les cartes de crédit,ses avantages et ses limtes.

  
   1.PrÃ©sentation du SVM
  
  ParticuliÃ¨rement rÃ©cente(1995), le **svm** (support vector machine) est l'une des techniques d'apprentissage supervisÃ©e les mieux connues notament en terme de dÃ©tection de fraude.Elle s'applique Ã  la fois sur les problÃ©matiques de rÃ©gression que sur ceux de classifications. Dans le cadre de notre projet  et dans la plus part des cas, c'est cette derniÃ¨re qui est retenue.   

L'objectif est d'Ã©tudier l'appartenance des individus Ã  des groupes distincts( deux classes) c'est Ã  dire de trouver une frontiÃ¨re appellÃ©e hyperplan sÃ©parateur qui  separe au mieux les groupes de  donnÃ©es de l'echantillon;ce qui pose un problÃ¨me d'optimisation.

Toute la difficultÃ© repose alors  sur la faÃ§on  de trouver cette frontiÃ¨re qui peut prendre des formes multiples et d'allures  differentes.     

Toutefois il est possible de trouver cette frontiÃ¨re en  supposant  que que les donnÃ©es de l'Ã©chantillon peuvent Ãªtre lineairement sÃ©parables. Il s'agira alors de choisir parmi les frontiÃ¨res candidates, celle qui maximise la marge(le double de la distance qui sÃ©pare les points supports Ã  la frontiÃ¨res) entre les deux groupes. 

 Comme dans la pratique les donnÃ©es de l'Ã©chantillon ne sont pas linÃ©airement separables, deux possibiliÃ©s s'offrent Ã  nous:    
 
   * resoudre le problÃ¨me en supposant que les donnÃ©es sont presque lineairment sÃ©parables en introduisant n variables  de ressorts(soft margin) sous contraintes de  classification c'est Ã  dire faire un arbitrage entre sous apprentissage et overfiting . Sachant  que le svm est trÃ¨s sensible au paramÃ¨tre de penalitÃ© induit par les variables de ressorts(**slack variables**), le choix des ces hyperparamÃ¨tres  constitue l'une des parties les plus importantes pour le reste de l'analyse. 
  

####Quelle est la deuxiÃ¨ment alternative?
  
  * On passe les donnÃ©es de depart dans un espace de plus grande dimension Ã  partir d'une focntion de  transformation dans le quel les donnnÃ©es peuvent Ãªtre linÃ©airement sÃ©parables. On l'appelle l'astuce kernel c'est Ã  dire une focntion obtenue par produit scalaire  des fonctions de transformations.  
  
#### pourquoi le kernel?
l'avantage du kernel est qu'il  peut s'adapter au cas oÃ¹ les donnÃ©es sont linÃ©airement sÃ©parables(*kernel lineaire*) et le cas oÃ¹ les donnÃ©es ne sont pas  linÃ©airement sÃ©parable (*kernel  polynomiale,guaussien,et perceptron*), ce qui nous conduit Ã  retenir cette deuxiÃ¨me solution pour la suite de l'appplication  avec ou sans variables de ressorts 


#### comment dÃ©velopper le svm 

Dans la pratique, l'algorithme est implÃ©menter dans plusieurs logiciels: 
SAS,PHYTON,MATLAB,R etc...,.
Dans le carde de cet projet, l'objectif sera de developper une application web shiny (en lien avec R) illustratif de la dÃ©tection de la fraude sur les cartes de crÃ©dits des clients de la banque en utilisant le svm comme nouveau modÃ¨le. 

  
   2.Description des donnÃ©es du projet
    
     a.Variables utilisÃ©es
     
   | Variables | Type         |
   | :--------:|-------------:|
   | Time      | qualitatif   | 
   | V1        | quantitatif  |
   | V2        | qualitatif   | 
   | V3        | quantitatif  |
   | V4        | quantitatif  |
   | V5        | quantitatif  |
   | V6        | quantitatif  |
   | V7        | quantitatif  |
   | V9        | quantitatif  |
   | V10       | quantitatif  |
   | V11       | quantitatif  |
   | V12       | quantitatif  |
   | V13       | quantitatif  |
   | V14       | quantitatif  |
   | V15       | quantitatif  |
   | V14       | quantitatif  |
   | V15       | quantitatif  |
   | V16       | quantitatif  |
   | V17       | quantitatif  |
   | V18       | quantitatif  |
   | V19       | quantitatif  | 
   | V20       | quantitatif  |
   | V21       | quantitatif  |
   | V22       | quantitatif  |
   | V23       | quantitatif  |
   | V24       | quantitatif  |
   | V25       | quantitatif  |
   | V26       | quantitatif  |
   | V27       | quantitatif  |
   | V28       | quantitatif  |
   | Amount    | quantitatif  |
   | Class     | quantitatif  |
   
   3.Les avantages du SVM
On obtient le taux d'erreur le plus petit avec le kernel radial.
   
   4.Les limites du SVM
Nous avons comparer les performances du SVM au gardient boosting et à la regression logistique
 
