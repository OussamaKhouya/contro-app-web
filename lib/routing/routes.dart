const RootRoute = "/";

const HomePageDisplayName = "Accueil";
const HomePageRoute = "/accueil";

const CmdPageDisplayName = "Commandes";
const CmdPageRoute = "/commandes";

const GalleryPageDisplayName = "List des Articles";
const GalleryPageRoute = "/gallery";

const AuthenticationPageDisplayName = "Se déconnecter";
const AuthenticationPageRoute = "/login";

class MenuItem{
  final String name;
  final String route;

  MenuItem(this.name, this.route);

}

List<MenuItem> sideMenuItems = [
  MenuItem(HomePageDisplayName, HomePageRoute),
  MenuItem(CmdPageDisplayName, CmdPageRoute),
  // MenuItem(GalleryPageDisplayName, GalleryPageRoute),
  MenuItem(AuthenticationPageDisplayName, AuthenticationPageRoute),

];