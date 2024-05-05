#' @export
transport_network_distance <- function(x, from,
                                       to = NULL,
                                       by_element = FALSE) {
  if (by_element) {
    vec_check_size(from, vec_size(to))
  }

  nodes <- transport_network_nodes(x)
  from <- transport_network_nearest_nodes(from, nodes)

  if (is.null(to)) {
    to <- from
  } else {
    to <- transport_network_nearest_nodes(to, nodes)
  }

  cost <- sfnetworks::st_network_cost(x,
                                      from = from$node,
                                      to = to$node,
                                      weights = "length") |>
    units::drop_units() |>
    sweep(1L, units::drop_units(from$length),
          FUN = "+") |>
    sweep(2L, units::drop_units(to$length),
          FUN = "+") |>
    units::set_units("m")

  if (by_element) {
    diag(cost)
  } else {
    cost
  }
}
