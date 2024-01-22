<?php

unset($CFG);
global $CFG;
$CFG = new stdClass();
$CFG->dbtype    = 'mysqli';
$CFG->dblibrary = 'native';
$CFG->dbhost    = $_ENV['moodle_DB_HOST'];
$CFG->dbname    = 'moodle';
$CFG->dbuser    = $_ENV['moodle_DB_USER'];
$CFG->dbpass    = $_ENV['moodle_DB_PASSWORD'];
$CFG->prefix    = 'mdl_';
$CFG->dboptions = array(
    'dbcollation' => 'utf8mb4_unicode_ci', // MySQL has partial and full UTF-8
);

$CFG->wwwroot   = 'http://moodledev.tld';
$CFG->dataroot  = '/var/www/data';
$CFG->directorypermissions = 02777;
$CFG->admin = 'admin';

require_once(__DIR__ . '/lib/setup.php'); // Do not edit
