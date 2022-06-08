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
    {""Réalisateur": "Raoul Walsh"}
    
    
    
    
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

