class Pokemon
    attr_accessor :name, :id, :type, :db, :hp
    
    def initialize (id:,name:,type:,db:,hp:nil)
        @name=name
        @id=id
        @type=type
        @db=db
        @hp=hp
    end

    def self.save(name,type,db)   
          sql = <<-SQL
            INSERT INTO pokemon (name,type)
            VALUES (?, ? )
          SQL
          db.execute(sql, name, type)   
          id = db.execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
          Pokemon.new(id:id,name:name,type:type,db:db)

    end

    def self.find(id,db)
        sql = "SELECT * FROM pokemon WHERE id = ?"
    result = db.execute(sql, id)[0]
    Pokemon.new(id:result[0], name:result[1], type:result[2],db:db,hp:result[3])
    end

    def alter_hp(hp,db)
        db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
    end





   
    

    
  
end
