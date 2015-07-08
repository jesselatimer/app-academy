module Saveable

  def save
    ivar_names = instance_variables.drop(1).map { |x| x.to_s[1..-1] }
    ivars = instance_variables.drop(1).map do |el|
      instance_variable_get(el.to_s)
    end
    table = self.class.to_s.downcase.pluralize
    question_marks = Array.new(ivars.count) { "?" }.join(", ")

    if @id.nil?
      data = QuestionsDatabase.instance.execute(<<-SQL, *ivars)
        INSERT INTO
          #{table} (#{ivar_names.join(", ")})
        VALUES
          (#{question_marks})
      SQL
      @id = QuestionsDatabase.instance.last_insert_row_id
    else
      data = QuestionsDatabase.instance.execute(<<-SQL, *ivars)
        UPDATE
          #{table}
        SET
          #{ivar_names.map { |name| "#{name} = ?" }.join(", ")}
        WHERE
          id = #{@id}
      SQL
    end
  end

end
