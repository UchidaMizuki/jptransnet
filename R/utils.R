transport_network_nearest_nodes <- function(x, nodes) {
  x <- x |>
    sf::st_transform(sf::st_crs(nodes)) |>
    sf::st_as_sf() |>
    dplyr::select()
  x |>
    sf::st_join(nodes,
                join = sf::st_nearest_feature) |>
    dplyr::mutate(length = sf::st_distance(sf::st_geometry(.env$x), vec_slice(nodes, .data$node),
                                           by_element = TRUE)) |>
    sf::st_drop_geometry()
}

transport_network_nodes <- function(x) {
  x |>
    sfnetworks::activate("nodes") |>
    tibble::as_tibble() |>
    tibble::rowid_to_column("node")
}

transport_network_edges <- function(x) {
  x |>
    sfnetworks::activate("edges") |>
    tibble::as_tibble() |>
    tibble::rowid_to_column("edge")
}
