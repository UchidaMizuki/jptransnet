#' @export
transport_network <- function(type = "global_map_v2_2") {
  switch(
    type,
    global_map_v2_2 = jptransnetdata::transport_network_global_map_v2_2
  )
}
