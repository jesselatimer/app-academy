class Employee
  attr_reader :title, :salary, :boss, :super_salary

  def initialize(title, salary, boss = nil)
    @title = title
    @salary = salary
    @boss = boss
    @super_salary = 0
  end

  def bonus(multiplier)
    @salary * multiplier
  end
end

class Manager < Employee
  attr_reader :super_salary

  def initialize(title, salary, boss = nil, sub_employees)
    super(title, salary, boss)
    @sub_employees = sub_employees
    @super_salary = sub_employees.inject(0){|sum, employee| sum  + employee.super_salary + employee.salary}
  end

  def bonus(multiplier)
    @super_salary * multiplier
  end

end

shawna = Employee.new('TA', 12000, "Darren")
david = Employee.new('TA', 10000, "Darren")
darren = Manager.new('TA Manager', 78000, "Ned", [shawna, david])
ned = Manager.new('Founder', 1_000_000, nil, [darren])

p ned.super_salary
p ned.bonus(5)
p darren.bonus(4)
p david.bonus(3)
