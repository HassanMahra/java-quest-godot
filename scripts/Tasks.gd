# Task definitions for the game
extends Node

class Task:
	var id: int
	var from: String
	var subject: String
	var body: String
	var difficulty: String
	var reward: int
	var xp: int
	var file_name: String
	var initial_code: String
	var solution_keywords: Array
	var forbidden_keywords: Array
	var success_message: String
	var error_message: String
	var hint: String

var tasks := []

func _ready():
	load_tasks()

func load_tasks():
	# Task 1: Fix the boolean typo
	var task1 = Task.new()
	task1.id = 1
	task1.from = "Chef"
	task1.subject = "Willkommen! Deine erste Aufgabe"
	task1.body = """Hallo neuer Kollege!

Willkommen bei TechCorp! Ich bin dein Chef, Herr Müller.

Deine erste Aufgabe ist ganz einfach: In der Datei Login.java gibt es einen Tippfehler. 
Der Datentyp "bollean" existiert nicht - es muss "boolean" heißen.

Fix das und deploy!

Gruß,
Herr Müller"""
	task1.difficulty = "Einfach"
	task1.reward = 50
	task1.xp = 10
	task1.file_name = "Login.java"
	task1.initial_code = """public class Login {
    // FIXME: Da ist ein Tippfehler!
    public bollean isUserLoggedIn = true;
    
    public void checkLogin() {
        if (isUserLoggedIn) {
            System.out.println("User ist eingeloggt");
        }
    }
}"""
	task1.solution_keywords = ["boolean"]
	task1.forbidden_keywords = ["bollean"]
	task1.success_message = "✅ Kompilierung erfolgreich! Der Login funktioniert wieder."
	task1.error_message = "❌ Compiler Error: 'bollean' ist kein bekannter Datentyp."
	task1.hint = "Tipp: Schau dir die Zeile mit 'bollean' genau an..."
	tasks.append(task1)
	
	# Task 2: NullPointerException
	var task2 = Task.new()
	task2.id = 2
	task2.from = "Senior Dev (Lisa)"
	task2.subject = "Null Pointer Exception im User-Service"
	task2.body = """Hey!

Wir haben einen Bug im Produktivsystem. Der User-Service wirft eine NullPointerException.

Das Problem: Die Variable "userName" wird nie initialisiert, bevor sie benutzt wird.
Du musst sie mit einem Default-Wert initialisieren.

Deadline: Heute noch!

LG Lisa"""
	task2.difficulty = "Einfach"
	task2.reward = 75
	task2.xp = 15
	task2.file_name = "UserService.java"
	task2.initial_code = """public class UserService {
    private String userName;
    
    public void printWelcome() {
        // Dieser Code wirft NullPointerException!
        System.out.println("Willkommen, " + userName.toUpperCase());
    }
}"""
	task2.solution_keywords = ['userName = "', 'userName = \'']
	task2.forbidden_keywords = []
	task2.success_message = "✅ Keine NullPointerException mehr!"
	task2.error_message = "❌ java.lang.NullPointerException at UserService.java:6"
	task2.hint = "Tipp: Initialisiere die Variable: private String userName = \"...\";"
	tasks.append(task2)
	
	# Task 3: Infinite Loop
	var task3 = Task.new()
	task3.id = 3
	task3.from = "QA Team"
	task3.subject = "DRINGEND: Endlosschleife in Calculator"
	task3.body = """ACHTUNG! KRITISCH!

Der Server hängt sich auf wegen einer Endlosschleife im Calculator.

Das Problem: Die for-Schleife zählt nie hoch, weil das "i++" fehlt!

Bitte SOFORT fixen!

QA Team"""
	task3.difficulty = "Mittel"
	task3.reward = 100
	task3.xp = 25
	task3.file_name = "Calculator.java"
	task3.initial_code = """public class Calculator {
    public int sumUpTo(int n) {
        int sum = 0;
        
        // WARNUNG: Diese Schleife endet nie!
        for (int i = 0; i < n; ) {
            sum += i;
        }
        
        return sum;
    }
}"""
	task3.solution_keywords = ["i++", "i += 1", "i = i + 1"]
	task3.forbidden_keywords = []
	task3.success_message = "✅ Schleife repariert! Server läuft wieder."
	task3.error_message = "❌ TIMEOUT: Endlosschleife detektiert"
	task3.hint = "Tipp: for-Schleifen brauchen ein Inkrement: i++"
	tasks.append(task3)

func get_task_by_id(id: int):
	for task in tasks:
		if task.id == id:
			return task
	return null

func check_solution(task, code: String) -> bool:
	# Check for required keywords
	var has_solution = false
	for keyword in task.solution_keywords:
		if keyword in code:
			has_solution = true
			break
	
	# Check for forbidden keywords
	for forbidden in task.forbidden_keywords:
		if forbidden in code:
			return false
	
	return has_solution
