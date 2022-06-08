-- Création des documents 
{
  "_id": 1
  "Titre" : "Les Misérables",
  "Réalisateur" : "Tom Hooper",
  "Temps d'exécution" : 158  
}

{
  "_id": 2,
  "Titre": "Skyfall",
  "Réalisateur": "Sam Mendes",
  "Durée d'exécution": 137
}

{
  "_id": 3,
  "Titre": "Les grands hommes",
  "Réalisateur": "Raoul Walsh"
}

-- Recherche dans la collection video_recording
-- 1er document
    {"_id": 1}
    
-- 2eme document
    { "Titre": "Skyfall",}
    
-- 3eme document
    {"Réalisateur": "Raoul Walsh"}
    
    
-- DBLP
  -- Recherche
    -- 1. 
      {"type" : "Book"}
    -- 2.
      {year : {$gte : 2011}
    -- 3.
      {"type" : "Book", year : {$gte : 2014}}
    -- 4.
      {authors : "Toru Ishida"}
    -- 5.
      db.publis.distinct("publisher");
    -- 6.
      db.publis.distinct("authors");
    -- 7.
      $match:{authors : "Toru Ishida"}}
      $sort : { booktitle : 1, "pages.start" : 1 }
    -- 8.
      $match:{authors : "Toru Ishida"}
      $sort : { booktitle : 1, "pages.start" : 1 }
      $project : {title : 1, pages : 1}
    -- 9.
      $match:{authors : "Toru Ishida"}
      $group:{_id:null, total : { $sum : 1}}
    -- 10.
      $match:{year : {$gte : 2011}}
      $group:{_id:"$type", total : { $sum : 1}}
    -- 11.
      $unwind : "$authors" 
      $group : { _id : "$authors", number : { $sum : 1 } }
      $sort : {number : -1}

  -- Mapper
    -- 1. 
    var mapFunction = function () {
      if (this.type == "Book")
         emit(this.title, this);
     };

     var reduceFunction = function (key, values) {
        return {articles : values};
      };

     var queryParam = {query:{}, out:"result_set"};
     
     -- 2.
     var mapFunction = function () {
      if(this.type == "Book")
        emit(this.title, this.authors.length);
      };

     var reduceFunction = function (key, values) {
       return {articles : values};
     };

     var queryParam = {query:{}, out:"result_set"};
     
     -- 3.
     var mapFunction = function () {
       if(this.publisher=="Springer" && this.booktitle)
             emit(this.booktitle, 1);
           };

    var reduceFunction = function (key, values) {
       return Array.sum(values);
     };

    var queryParam = {query:{}, out:"result_set"};

    db.publis.mapReduce(mapFunction,
       reduceFunction, queryParam);

    db.result_set.find({value:{$gte:2}});
    
    -- 4.
    var mapFunction = function () {
       if(this.publisher == "Springer")emit(this.year, 1);
     };

    var reduceFunction = function (key, values) {
      return Array.sum(values);
    };
    
    -- 5.
    var mapFunction = function () {
      if(this.publisher)
          emit({publisher:this.publisher, year:this.year}, 1);
       };

    var reduceFunction = function (key, values) {
        return Array.sum(values);
     };
     
     -- 6. 
      var mapFunction = function () {
       if(Array.contains(this.authors, "Toru Ishida"))
         emit(this.year, 1);
      };

     var reduceFunction = function (key, values) {
        return Array.sum(values);
     };

     var queryParam = {query:{}, out:"result_set"};
     
     -- 7.
     var mapFunction = function () {
       emit(null, this.pages.end - this.pages.start);
    };

    var reduceFunction = function (key, values) {
      return Array.avg(values);
    };

    var queryParam = {query:{authors:"Toru Ishida"}, out:"result_set"};
    
    -- 8. 
    var mapFunction = function () {
     for(var i=0;i<this.authors.length;i++)
       emit(this.authors[i], this.title);};

    var reduceFunction = function (key, values) {
      return {titles : values};
    };
    
    -- 9.
    var mapFunction = function () {
      for(var i=0;i<this.authors.length;i++)
         emit({author : this.authors[i], year : this.year}, 1);};

    var reduceFunction = function (key, values) {
      return Array.sum(values);
    };
    
    -- 10.
    var mapFunction = function () {
      for(var i=0;i<this.authors.length;i++)
        emit(this.year, this.authors[i]);};

    var reduceFunction = function (key, values) {
      var distinct = 0;var authors = new Array();

      for(var i=0;i<values.length;i++)
        if(!Array.contains(authors, values[i]))
        {
             distinct++;
             authors[authors.length] = values[i];
         }

      return distinct;};
      
      -- 11.
      var mapFunction = function () {
         if(this.authors.length >3)emit(null, 1);
       };

      var reduceFunction = function (key, values) {
        return Array.sum(values);
      };
      
      -- 12.
      var mapFunction = function () {
        if(this.pages && this.pages.end)
          emit(this.publisher, this.pages.end - this.pages.start);
        };

       var reduceFunction = function (key, values) {
         return Array.avg(values);
       };

      var queryParam = {query:{}, out:"result_set"};
      
      -- 13.
       var mapFunction = function () {
         for(var i=0;i<this.authors.length;i++)
           emit(this.authors[i], {min : this.year,
                                  max : this.year, number : 1});};

       var reduceFunction = function (key, values) {

         var v_min = 1000000;var v_max = 0;var v_number = 0;

         for(var i=0;i<values.length;i++){
          if(values[i].min < v_min)v_min = values[i].min;
          if(values[i].max > v_max)v_max = values[i].max;
          v_number++;
         }
        return {min:v_min, max:v_max, number:v_number};
      };



-----------------------------------------------------------------------------------------------------------------------------------------------------------------------
-- Hadoop
/* L'architecture Hadoop est composé des éléments suivants :
    HDFS : le système de fichier distribué d’Apache Hadoop
    YARN : le gestionnaire de ressources et des tâches dans un cluster Hadoop
    MapReduce : un framework pour le traitement de grands ensembles de données en parallèle
    Spark : un moteur d’analyse unifié pour le traitement de données à grande échelle
    PIG, HIVE : Services de traitement de données à l’aide de requêtes du type SQL
    HBase : système de gestion de base de données non-relationnelles distribué
    Mahout, Spark MLlib : des services pour faire du Machine Learning
    Apache Drill : Moteur de requête SQL sur Hadoop
    Zookeeper : Pour la gestion de Cluster
    Oozie : Système de planification de workflow pour gérer les jobs Hadoop
    Flume, Sqoop : Services d’ingestion de données
    Solr & Lucene : Pour la recherche et l’indexation
    Ambari :  Mise à disposition, monitoring et maintenance de cluster
 
 
-- Hive
  L'architecture Hive est composé des éléments suivants :
    metastore : est chargé du stockage des métadonnées pour chaque table c'est-à-dire qu'il enregistre par exemple les schémas ainsi que les localisations. 
              Il inclut aussi des métadonnées de partitionnement afin d'aider le driver à suivre la distribution des bases de données au sein du cluster. 
              En pratique, les données sont stockées à la manière d'un SGBD relationnel traditionnel.
    driver : joue le rôle du contrôleur de processus recevant les instances HiveQL. Il lance l'exécution des instructions par l'intermédiaire de la création de
            sessions et il contrôle la progression de l'exécution ainsi que le cycle de vie des processus. Il conserve les métadonnées nécessaires générées durant 
            l'exécution des requêtes HiveQL. Le driver joue aussi le rôle de collecteur de données résultant des étapes Reduce.
    compiler : réalise la compilation des requêtes HiveQL.
    optimizer : réalise différentes transformations sur le plan d'exécution pour obtenir un DAG optimisé.
    executor : après les phases de compilation et de d'optimisation, il exécute les tâches fournies par le DAG.
    cLI, UI et Thrift Server : permettent à un utilisateur externe d’interagir avec Hive en soumettant des requêtes.


-- Hbase
  L'architecture Hbase est composé des éléments suivants :
    HMaster : L’implémentation de Master Server dans HBase est HMaster. Il s’agit d’un processus dans lequel les régions sont affectées au serveur de région ainsi 
              qu’aux opérations DDL (créer, supprimer une table). Il surveille toutes les instances de serveur de région présentes dans le cluster. Dans un 
              environnement distribué, Master exécute plusieurs threads d’arrière-plan. HMaster possède de nombreuses fonctionnalités telles que le contrôle de 
              l’équilibrage de charge, le basculement, etc. 
    Serveur de région : Les tables HBase sont divisées horizontalement par plage de clés de ligne en régions. Les régions sont les éléments de base du cluster HBase 
                        qui se compose de la distribution de tables et sont composées de familles de colonnes. Le serveur de région s’exécute sur HDFS DataNode qui est
                        présent dans le cluster Hadoop. Les régions de Region Server sont responsables de plusieurs choses, comme la gestion, la gestion, l’exécution 
                        ainsi que la lecture et l’écriture d’opérations HBase sur cet ensemble de régions. La taille par défaut d’une région est de 256 Mo. 
    Zookeeper : C’est comme un coordinateur dans HBase. Il fournit des services tels que la gestion des informations de configuration, le nommage, la synchronisation 
                distribuée, la notification de panne de serveur, etc. Les clients communiquent avec les serveurs de la région via zookeeper. */
