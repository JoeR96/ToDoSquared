using ToDoSquared.Models;

namespace ToDoSquared.Services;

public interface IToDoService
{
    public Task<ToDo> GetToDo(int toDoId);
}