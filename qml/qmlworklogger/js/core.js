// ---------------------------------------------------------------------------
//Copyright (C) 2008-2011 Nokia Corporation and/or its subsidiary(-ies).
//All rights reserved.
//Contact: Nokia Corporation (qt-info@nokia.com)

//You may use the files in this folder under the terms of the BSD
//license as follows:

//Redistribution and use in source and binary forms, with or without
//modification, are permitted provided that the following conditions are
//met:
//  * Redistributions of source code must retain the above copyright
//    notice, this list of conditions and the following disclaimer.
//  * Redistributions in binary form must reproduce the above copyright
//    notice, this list of conditions and the following disclaimer in
//    the documentation and/or other materials provided with the
//    distribution.
//  * Neither the name of Nokia Corporation and its Subsidiary(-ies) nor
//    the names of its contributors may be used to endorse or promote
//    products derived from this software without specific prior written
//    permission.

//THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS
//"AS IS" AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT
//LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR
//A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT
//OWNER OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL,
//SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT
//LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
//DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
//THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
// ---------------------------------------------------------------------------

.pragma library
var _db;
var TABLE_PROJECT = "project";
var DB_NAME = "WorkLogger"

function openDB() {
    _db = openDatabaseSync(DB_NAME, "1.0", "WorkLogger Database", 64000);
    createTable();
}

function createTable() {
    _db.transaction(function(tx) {
                        var query = "\
                            CREATE TABLE IF NOT EXISTS "+TABLE_PROJECT+
                            " (id INTEGER PRIMARY KEY AUTOINCREMENT, \
                            name TEXT,\
                            description TEXT,\
                            created DATE,\
                            started DATE,\
                            finished DATE)";
                        tx.executeSql(query);
                    });
}

function dropTable()
{
    _db.transaction(
                function(tx){
                    tx.executeSql("DROP TABLE IF EXISTS "+TABLE_PROJECT);
                }
                )
}

function insertProject(project) {
    openDB();
    _db.transaction(function(tx) {
                        var query = "INSERT INTO "+TABLE_PROJECT+" (name, description, created, started, finished) \
VALUES (?, ?, ?, ?, ?)";
                        var queryParams = [project.name, project.description, new Date(), null, null];
                        tx.executeSql(query, queryParams);
    });
}

function updateProject(id, project) {
    openDB();
    _db.transaction(function(tx) {
                        tx.executeSql("UPDATE "+TABLE_PROJECT+" SET name=?, description=?, \
                                       created=?, started=?, finished=? WHERE id=?",
                                      [project.name, project.description,
                                       project.created, project.started, project.finished, project.id]);
                    });
}

function readProjects() {
    openDB();
    var data = [];
    _db.readTransaction(function(tx){
                            var rs = tx.executeSql("SELECT * FROM "+TABLE_PROJECT);
                            for (var i = 0; i < rs.rows.length; i++) {
                                data[i] = rs.rows.item(i);
                            }
                        });
    return data;
}

function readProject(id) {
    openDB();
    var item = 0;
    _db.readTransaction(function(tx){
                            var rs = tx.executeSql("SELECT * FROM "+TABLE_PROJECT+" WHERE id=?", id);
                            if (rs.rows.length === 1) {
                                item = rs.rows.item(0);
                            }
                        });
    return item;
}

//.pragma library

//var _db;

//function openDB() {
//    _db = openDatabaseSync("TodoDB","1.0","the Todo related Database",1000000);
//    createTable();
//}

//function createTable(){
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("CREATE TABLE IF NOT EXISTS todo (id INTEGER PRIMARY KEY AUTOINCREMENT, box INTEGER, done TEXT, title TEXT, note TEXT, modified TEXT)");
//                }
//                )
//}

//function dropTable()
//{
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("DROP TABLE IF EXISTS todo");
//                }
//                )
//}

//function readTodos()
//{
//    var data = [];
//    _db.readTransaction(
//                function(tx){
//                    var rs = tx.executeSql("SELECT * FROM todo ORDER BY modified DESC");
//                    for (var i=0; i< rs.rows.length; i++) {
//                        data[i] = rs.rows.item(i);
//                    }

//                }
//                )
//    return data;
//}

//function updateTodo(todoItem)
//{
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("UPDATE todo SET BOX = ? , done = ?, \
//                                  title = ?, note = ?, modified = ?  \
//                                  WHERE id = ?", [todoItem.box, todoItem.done, todoItem.title,
//                                                  todoItem.note, todoItem.modified, todoItem.id]);
//                }
//                )
//}


//function deleteTodo(id)
//{
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("DELETE FROM todo WHERE id = ?", id);
//                }
//                )
//}

//function createTodo(todoItem)
//{
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[todoItem.box, todoItem.done, todoItem.title, todoItem.note, todoItem.modified]);
//                }
//                )
//}


//function readTodoBox(model, box)
//{
//    model.clear()
//    _db.readTransaction(
//                function(tx){
//                    var rs = tx.executeSql("SELECT * FROM todo WHERE box =? ORDER BY modified DESC", [box]);
//                    for (var i=0; i< rs.rows.length; i++) {
//                        model.append(rs.rows.item(i))
//                    }
//                }
//                )
//}

//function readTodoItem(todoId) {
//    var data = {}
//    _db.readTransaction(
//                function(tx){
//                    var rs = tx.executeSql("SELECT * FROM todo WHERE id=?", [todoId])
//                    if(rs.rows.length === 1) {
//                        data = rs.rows.item(0)
//                    }
//                }
//                )
//    return data;
//}

//function printObject(o)
//{
//    print('---')
//    print(Object.keys(o))
//    for(var key in o) {
//        print("  " + key +"="+o[key])
//    }

//}

//function countBox(boxId)
//{
//    var data = 0;
//    _db.readTransaction(
//                function(tx){
//                    var rs = tx.executeSql("SELECT count(*) FROM todo WHERE box = ?",[boxId]);
//                    if(rs.rows.length === 1) {
//                        data = rs.rows.item(0)["count(*)"]
//                    }

//                }
//                )
//    return data;
//}

//function createBatchTodos(data)
//{
//    _db.transaction(
//                function(tx){
//                    for(var i=0; i<data.length; i++) {
//                        var item = data[i]
//                        tx.executeSql("INSERT INTO todo (box, done, title, note, modified) VALUES(?,?,?,?,?)",[item.box, item.done, item.title, item.note, item.modified]);
//                    }
//                }
//                )
//}

//function clearArchive(model)
//{
//    model.clear()
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("DELETE FROM todo WHERE box = 4");
//                }
//                )
//}

//function updateArchive(box)
//{
//    _db.transaction(
//                function(tx){
//                    tx.executeSql("UPDATE todo SET box = 4 WHERE done = 'true' AND box=?",box);
//                }
//                )
//}

//function defaultItem()
//{
//    return {box: 0, done: false, title: "", note: "", modified: new Date()}
//}

