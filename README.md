# MostFreeTime

**TODO: Add description**

## Compilation

`mix compile`:
`iex -S mix`:


El algoritmo consiste en poner una entrada como la siguiente: ["12:15PM-02:00PM", "09:00AM-10:00AM", "10:30AM-12:00PM"]
Y determinar cual es el espacio en horas:minutos que se tiene mas libre, dentro de dichos horarios.
Para el ejemplo anterior, la respuesta deberia ser "00:30".

## Examples

iex> MostFreeTime.most_free_time(["12:15PM-02:00PM", "09:00AM-10:00AM", "10:30AM-12:00PM"])
"00:30"

