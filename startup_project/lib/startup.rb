require "employee"

class Startup
    attr_reader :name, :funding, :salaries, :employees
    def initialize(name, funding, salaries)
        @name = name
        @funding = funding
        @salaries = salaries
        @employees = []
    end

    def valid_title?(title)
        @salaries.keys.include? title
    end

    def >(startup)
        @funding > startup.funding
    end

    def hire(name, title)
        raise ArgumentError if !(valid_title?(title))
        @employees << Employee.new(name, title)
    end

    def size
        @employees.length
    end

    def pay_employee(emp)
        if @funding < @salaries[emp.title]
            raise ArgumentError
        end
        emp.pay(@salaries[emp.title])
        @funding -= @salaries[emp.title]
    end

    def payday
        @employees.each do |emp|
            pay_employee(emp)
        end
    end

    def average_salary
        sum = 0
        @employees.each do |emp|
            sum += @salaries[emp.title]
        end
        sum / @employees.length
    end

    def close
       @employees = []
       @funding = 0
    end

    def acquire(startup)
        @funding += startup.funding
        startup.salaries.each do |title, salary|
            @salaries[title] = salary if !@salaries.include?(title)
        end
        @employees += startup.employees
        startup.close
    end

end
