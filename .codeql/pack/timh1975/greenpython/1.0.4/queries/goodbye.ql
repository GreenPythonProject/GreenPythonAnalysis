/** 
 * @name GreenPython
 * @kind problem
 * @problem.severity warning
 * @id python/example/goodbye
 */

 import python

 from Function f
 where f.getName() = "goodbye"
 select f, "Goodbye function found" as message