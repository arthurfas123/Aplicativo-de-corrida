import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../controllers/user_controller.dart';
import '../../data/models/atividade.dart';

class StatisticPage extends StatefulWidget {
  const StatisticPage({super.key});

  @override
  State<StatisticPage> createState() => _StatisticPageState();
}

class _StatisticPageState extends State<StatisticPage> {
  Map<DateTime, List<Atividade>> diasMarcados = {};
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;

  @override
  void initState() {
    super.initState();
    carregarAtividades();
  }

  void carregarAtividades() {
    final usuario = UserController.instance.usuarioAtual;
    if (usuario != null) {
      for (var atividade in usuario.atividades) {
        final data = DateTime(atividade.data.year, atividade.data.month, atividade.data.day);
        diasMarcados.putIfAbsent(data, () => []).add(atividade);
      }
      setState(() {});
    }
  }

  Duration somaTempoTotal(List<Atividade> atividades) {
    Duration total = Duration();
    for (var atividade in atividades) {
      final partes = atividade.tempo_min_seg.split(':');
      if (partes.length == 2) {
        final minutos = int.tryParse(partes[0]) ?? 0;
        final segundos = int.tryParse(partes[1]) ?? 0;
        total += Duration(minutes: minutos, seconds: segundos);
      }
    }
    return total;
  }

  String formatDuration(Duration duracao) {
    String doisDigitos(int n) => n.toString().padLeft(2, '0');
    final horas = duracao.inHours;
    final minutos = duracao.inMinutes.remainder(60);
    final segundos = duracao.inSeconds.remainder(60);
    if (horas > 0) {
      return '${doisDigitos(horas)}:${doisDigitos(minutos)}:${doisDigitos(segundos)}';
    } else {
      return '${doisDigitos(minutos)}:${doisDigitos(segundos)}';
    }
  }

  Future<void> _selecionarAno(BuildContext context) async {
    final anoAtual = _focusedDay.year;
    final novoAno = await showDialog<int>(
      context: context,
      builder: (context) {
        int anoSelecionado = anoAtual;
        return AlertDialog(
          title: Text('Selecione o ano'),
          content: SizedBox(
            width: 300,
            height: 300,
            child: YearPicker(
              firstDate: DateTime(2020),
              lastDate: DateTime(2030),
              selectedDate: DateTime(anoAtual),
              onChanged: (DateTime dateTime) {
                anoSelecionado = dateTime.year;
                Navigator.pop(context, anoSelecionado);
              },
            ),
          ),
        );
      },
    );

    if (novoAno != null && novoAno != anoAtual) {
      setState(() {
        _focusedDay = DateTime(novoAno, _focusedDay.month, _focusedDay.day);
        _selectedDay = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final anoAtual = _focusedDay.year;

    // Filtra as datas marcadas que são do ano selecionado
    final Map<DateTime, List<Atividade>> diasDoAno = Map.fromEntries(
      diasMarcados.entries.where(
            (entry) => entry.key.year == anoAtual,
      ),
    );

    final totalDias = diasDoAno.length;
    double totalKm = 0;
    Duration totalTempo = Duration();

    for (var atividades in diasDoAno.values) {
      for (var a in atividades) {
        totalKm += double.tryParse(a.distancia_em_km.replaceAll(',', '.')) ?? 0;
      }
      totalTempo += somaTempoTotal(atividades);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Estatísticas'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            tooltip: 'Selecionar ano',
            onPressed: () => _selecionarAno(context),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: TableCalendar<Atividade>(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focusedDay,
              selectedDayPredicate: (day) => isSameDay(_selectedDay, day),
              onDaySelected: (selectedDay, focusedDay) {
                setState(() {
                  _selectedDay = selectedDay;
                  _focusedDay = focusedDay;
                });

                final data = DateTime(selectedDay.year, selectedDay.month, selectedDay.day);
                final atividades = diasMarcados[data] ?? [];

                showDialog(
                  context: context,
                  builder: (_) => AlertDialog(
                    title: Text('${data.day.toString().padLeft(2, '0')}/'
                        '${data.month.toString().padLeft(2, '0')}/'
                        '${data.year}'),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: atividades.map((a) => ListTile(
                        title: Text(a.titulo),
                        subtitle: Text('${a.distancia_em_km} km – ${a.tempo_min_seg}'),
                      )).toList(),
                    ),
                  ),
                );
              },
              eventLoader: (day) {
                final data = DateTime(day.year, day.month, day.day);
                return diasMarcados[data] ?? [];
              },
              calendarStyle: CalendarStyle(
                selectedDecoration: BoxDecoration(
                  color: Colors.blueAccent,
                  shape: BoxShape.circle,
                ),
                markerDecoration: BoxDecoration(
                  color: Colors.green,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.green, width: 1.5),
                ),
                markersMaxCount: 1,
              ),
              headerStyle: HeaderStyle(
                formatButtonVisible: false,
              ),
              calendarBuilders: CalendarBuilders(
                markerBuilder: (context, day, events) {
                  if (events.isNotEmpty) {
                    return Positioned(
                      bottom: 6,
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: BoxDecoration(
                          color: Colors.green,
                          shape: BoxShape.circle,
                        ),
                      ),
                    );
                  }
                  return null;
                },
              ),
            ),
          ),
          SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 2,
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text('Dias Corridos', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text('$totalDias'),
                      SizedBox(height: 12),
                      Text('Km Totais', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(totalKm.toStringAsFixed(2)),
                      SizedBox(height: 12),
                      Text('Tempo Total', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                      SizedBox(height: 4),
                      Text(formatDuration(totalTempo)),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }
}
