import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todo_app/models/models.dart';
import 'package:todo_app/service/service.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  final TodoService todoService;
  TodoBloc(this.todoService) : super(TodoInitial()) {
    on<FetchTodo>((event, emit) async{
      emit(TodoLoading());
      try {
        final todos = await todoService.getAllTodos();
        emit(TodoLoaded(todos));
      } catch(e){
        emit(TodoError(e.toString()));
      }
    });

    on<AddTodo>((event , emit) async{
      try{
        await todoService.addTodos(event.todo.title, event.todo.description);
        add(FetchTodo());
      } catch(e) {
        emit(TodoError(e.toString()));
      }
    });

    on<UpdateTodo>((event , emit) async{
      try{
        await todoService.updateTodo(event.todo);
        add(FetchTodo());
      } catch(e){
        emit(TodoError(e.toString()));
      }
    });

    on<DeleteTodo>((event , emit) async{
      try{
        await todoService.deleteTodo(event.id);
        add(FetchTodo());
      } catch(e){
        emit(TodoError(e.toString()));
      }
    });
  }
}
