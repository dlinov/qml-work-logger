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
var TABLE_TASK = "task";
var TABLE_TASK_PART = "task_part"
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
            finished DATE);";
        tx.executeSql(query);
        query = "\
            CREATE TABLE IF NOT EXISTS "+TABLE_TASK+
            " (id INTEGER PRIMARY KEY AUTOINCREMENT,\
            name TEXT,\
            description TEXT,\
            created DATE,\
            projectId INTEGER,\
            FOREIGN KEY(projectId) REFERENCES "+TABLE_PROJECT+"(id));";
        tx.executeSql(query);
        query = "\
            CREATE TABLE IF NOT EXISTS "+TABLE_TASK_PART+
            " (id INTEGER PRIMARY KEY AUTOINCREMENT,\
            started DATE,\
            ended DATE,\
            isLogged INTEGER,\
            description TEXT,\
            taskId INTEGER,\
            FOREIGN KEY(taskId) REFERENCES "+TABLE_TASK+"(id));";
        tx.executeSql(query);
    });
}

function dropTables() {
    _db.transaction(function(tx) {
        tx.executeSql("DROP TABLE IF EXISTS "+TABLE_TASK_PART);
        tx.executeSql("DROP TABLE IF EXISTS "+TABLE_TASK);
        tx.executeSql("DROP TABLE IF EXISTS "+TABLE_PROJECT);
    });
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

function updateProject(project) {
    openDB();
    _db.transaction(function(tx) {
        var query = "UPDATE "+TABLE_PROJECT+" SET name=?, description=?, created=?, started=?, finished=? WHERE id=?";
        var queryParams = [project.name, project.description, project.created, project.started, project.finished, project.id];
        tx.executeSql(query, queryParams);
    });
}

function readProjects() {
    openDB();
    var data = [];
    _db.readTransaction(function(tx) {
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
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_PROJECT+" WHERE id=?", id);
        if (rs.rows.length === 1) {
            item = rs.rows.item(0);
        }
    });
    return item;
}

function removeProject(id) {
    openDB();
    _db.transaction(function(tx) {
        var rs = tx.executeSql("DELETE FROM "+TABLE_PROJECT+" WHERE id=?", id);
    });
}

function insertTask(task) {
    openDB();
    _db.transaction(function(fx) {
        var query = "INSERT INTO "+TABLE_TASK+" (name, description, created, projectId) \
VALUES (?, ?, ?, ?, ?)";
        var queryParams = [task.name, task.description, new Date(), task.projectId];
        tx.executeSql(query, queryParams);
    })
}

function updateTask(task) {
    openDB();
    _db.transaction(function(tx) {
        var query = "UPDATE "+TABLE_TASK+" SET name=?, description=?, created=?, projectId=? WHERE id=?";
        var queryParams = [task.name, task.description, task.created, task.projectId, task.id];
        tx.executeSql(query, queryParams);
    });
}

function readTasks() {
    openDB();
    var data = [];
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_TASK);
        for (var i = 0; i < rs.rows.length; i++) {
            data[i] = rs.rows.item(i);
        }
    });
    return data;
}

function readTask(id) {
    openDB();
    var item = 0;
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_TASK+" WHERE id=?", id);
        if (rs.rows.length === 1) {
            item = rs.rows.item(0);
        }
    });
    return item;
}

function readTasksCountForProject(projectId) {
    openDB();
    var rowsCount = 0;
    _db.readTransaction(function(tx) {
        rowsCount = tx.executeSql("SELECT COUNT(*) as count FROM "+TABLE_TASK+" WHERE projectId=?", projectId);
    });
    return rowsCount.rows.item(0).count;
}

function removeTask(id) {
    openDB();
    // TODO: remove all task parts
    _db.transaction(function(tx) {
        var rs = tx.executeSql("DELETE FROM "+TABLE_TASK+" WHERE id=?", id);
    });
}

function insertTaskPart(taskPart) {
    openDB();
    _db.transaction(function(fx) {
        var query = "INSERT INTO "+TABLE_TASK_PART+" (started, ended, isLogged, description, taskId) \
VALUES (?, ?, ?, ?, ?)";
        var queryParams = [taskPart.started, taskPart.ended, taskPart.isLogged, taskPart.description, taskPart.taskId];
        tx.executeSql(query, queryParams);
    });
}

function updateTaskPart(taskPart) {
    openDB();
    _db.transaction(function(tx) {
        var query = "UPDATE "+TABLE_TASK_PART+" SET started=?, ended=?, isLogged = ?, description=?, taskId=? WHERE id=?";
        var queryParams = [taskPart.started, taskPart.ended, taskPart.isLogged, taskPart.description, taskPart.taskId, taskPart.id];
        tx.executeSql(query, queryParams);
    });
}

function readTaskParts() {
    openDB();
    var data = [];
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_TASK_PART);
        for (var i = 0; i < rs.rows.length; i++) {
            data[i] = rs.rows.item(i);
        }
    });
    return data;
}

function readTaskPart(id) {
    openDB();
    var item = 0;
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_TASK_PART+" WHERE id=?", id);
        if (rs.rows.length === 1) {
            item = rs.rows.item(0);
        }
    });
    return item;
}

function readTaskPartsForTask(taskId) {
    openDB();
    var data = [];
    _db.readTransaction(function(tx) {
        var rs = tx.executeSql("SELECT * FROM "+TABLE_TASK_PART+" WHERE taskId=?", taskId);
        for (var i = 0; i < rs.rows.length; i++) {
            data[i] = rs.rows.item(i);
        }
    });
    return data;
}

function removeTaskPart(id) {
    openDB();
    _db.transaction(function(tx) {
        var rs = tx.executeSql("DELETE FROM "+TABLE_TASK_PART+" WHERE id=?", id);
    });    
}
