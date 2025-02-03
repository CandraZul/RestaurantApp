enum NavigationRoute {
 mainRoute("/"),
 detailRoute("/detail"),
 favoriteRoute("/favorite");
 
 const NavigationRoute(this.name);
 final String name;
}