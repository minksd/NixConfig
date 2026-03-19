let
  minksdHome = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIPODHCes9I0A6TBXsvIhLe/wiVF9l/cOctdA7c9kFIVT minksd@minksdHome";
  minksdLaptop = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIKqfui2LI/B5DsFeAPkduoQkRKn78p0Jdy9s0BPIZVkJ minksd@minksdLaptop";
  users = [
    minksdHome
    minksdLaptop
  ];

  homeSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAILylSBBn9xqo3z8ljF4VrYtOlXpBN3WzymWqhZW+WF+r root@minksdHome";
  laptopSystem = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINFSzzkZ3HUGwJZTY7x9lohW3IAq1kOKZULrdtng+wbr root@minksdLaptop";
  systems = [
    homeSystem
    laptopSystem
  ];
in
{
  "minksdPass.age" = {
    publicKeys = users ++ systems;
    armor = true;
  };
  "minksdU2F.age" = {
    publicKeys = users ++ systems;
    armor = true;
  };
  "wg-minksdHome.age" = {
    publicKeys = users ++ systems;
    armor = true;
  };
  "wg-minksdLaptop.age" = {
    publicKeys = users ++ systems;
    armor = true;
  };
  "minksdHome-ddns.age" = {
    publicKeys = [
      minksdHome
      homeSystem
    ];
    armor = true;
  };

}
