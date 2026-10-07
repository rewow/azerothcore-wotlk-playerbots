-- Register mod-playerbots' data/sql/characters/ (base/ and updates/, walked recursively) as an update
-- include dir, so the worldserver's updater applies and tracks the module's acore_characters sql
-- itself - the module ships it outside the data/sql/db-characters/ layout the updater picks up for modules.
-- '$' is the server's SourceDirectory: this path resolves to the same module dir from
-- azerothcore-wotlk (C# server) and azerothcore-wotlk-playerbots (C++ server).
-- The updater reads updates_include before applying anything, so the module sql is applied on the
-- start after the one that runs this file. Idempotent: a path already registered is left alone.
INSERT INTO `updates_include` (`path`, `state`)
SELECT '$/../azerothcore-wotlk-playerbots/modules/mod-playerbots/data/sql/characters', 'CUSTOM' FROM DUAL
WHERE NOT EXISTS (SELECT 1 FROM `updates_include` WHERE `path` = '$/../azerothcore-wotlk-playerbots/modules/mod-playerbots/data/sql/characters');
