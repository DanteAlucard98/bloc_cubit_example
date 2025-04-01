import 'package:bloc_cubits_test/presentation/blocs/counter_bloc/counter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BlocCounterScreen extends StatelessWidget {
  const BlocCounterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CounterBloc(),
      child: const BlocCounterView(),
    );
  }
}

class BlocCounterView extends StatelessWidget {
  const BlocCounterView({
    super.key,
  });

  void increaseCounterBy(BuildContext context, [int value = 1]){
    //context.read<CounterBloc>().add(CounterIncreased(value));
    context.read<CounterBloc>().increaseBy(value);
  }

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: context.select((CounterBloc value) => Text('Bloc Counter: ${value.state.transactionCount}')),
        actions: [
          IconButton(
            onPressed: () => context.read<CounterBloc>().reset(),
            icon: const Icon(Icons.refresh),
          ), 
        ],
      ),
      body: Center(
        child: context.select((CounterBloc value) => Text('Counter value: ${value.state.counter}')
        ),
        
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            heroTag: '1',
            onPressed: () => increaseCounterBy(context, 3),
            child: Text('+3'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: '2',
            onPressed: () => increaseCounterBy(context, 2),
            child: Text('+2'),
          ),
          const SizedBox(height: 10),
          FloatingActionButton(
            heroTag: '3',
            onPressed: () => increaseCounterBy(context),
            child: Text('+1'),
          ),
        ],
      ),
    );
  }
}