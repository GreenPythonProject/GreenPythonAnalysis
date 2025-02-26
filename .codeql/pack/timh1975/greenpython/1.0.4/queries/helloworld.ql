/** 
 * @name Hello World
 * @kind problem
 * @problem.severity warning
 * @id python/example/hello-world
 */

 import python

 from Function f
 where f.getName() = "helloWorld"
 select f, "Hello World function found" as message