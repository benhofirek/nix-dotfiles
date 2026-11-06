{ inputs, lib, ... }:

let
  # Recursively find subdirectories containing SKILL.md.
  # Names come from readDir keys, so they carry no store path context.
  findSkills = dir:
    if !builtins.pathExists dir then [ ] else
    let
      subdirs = lib.filterAttrs
        (_: type: type == "directory")
        (builtins.readDir dir);
    in
    lib.concatLists (lib.mapAttrsToList
      (name: _:
        let path = dir + "/${name}"; in
        if builtins.pathExists (path + "/SKILL.md")
        then [ { inherit name path; } ]
        else findSkills path)
      subdirs);

  # Discover skills from every configured repository.
  repos = with inputs; [
    matt-pocock-skills
    ponytail-skills
    caveman-skills
  ];

  skills = lib.concatMap
    (repo: findSkills (repo + "/skills"))
    repos;

  skillFiles = lib.listToAttrs (
    map
      (skill: {
        name = ".agents/skills/${skill.name}";
        value.source = skill.path;
      })
      skills
  );
in
{
  home.file = skillFiles;
}
