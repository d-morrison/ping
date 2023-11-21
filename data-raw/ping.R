load_all()

# get data from "ping ucdavis.edu" or similar

ping = process_pings_file("inst/extdata/ping_data.txt")

ping |> graph_pings()
