#' @export
transport_network_path <- function(x, from, to) {
  vec_check_size(from, 1)

  nodes <- transport_network_nodes(x)
  edges <- transport_network_edges(x)

  from <- transport_network_nearest_nodes(from, nodes)
  to <- transport_network_nearest_nodes(to, nodes)

  sfnetworks::st_network_paths(x,
                               from = from$node,
                               to = to$node,
                               weights = "length") |>
    dplyr::mutate(nodes = .data$node_paths |>
                    purrr::map(\(node_paths) vec_slice(nodes, node_paths)),
                  edges = .data$edge_paths |>
                    purrr::map(\(edge_paths) vec_slice(edges, edge_paths)),
                  length = .data$edges |>
                    purrr::map_vec(\(edges) sum(edges$length)),
                  length = .env$from$length + .data$length + .env$to$length,
                  .keep = "unused")
}
