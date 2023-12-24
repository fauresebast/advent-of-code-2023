# standard:disable Security/Eval
module Day19
  def self.parse(input)
    workflow_lines, part_lines = input.split("\n\n")
    workflows = workflow_lines.split("\n").to_h do |line|
      label = line[/^[a-z]+/]
      flow = line[/(?<={).*(?=})/].gsub(/([a-z]{2,}|[A-Z])/) { "'#{$&}'" }.gsub(":", " ? ").gsub(",", " : ").gsub(/(?<=:) [axm].*?\?.*?:.*/) { "(#{_1})" }
      [label, ->(x, m, a, s) { eval flow }]
    end
    parts = part_lines.split("\n").map { |line| eval line.tr("=", ":") }
    [workflows, parts]
  end

  def self.part1(input)
    workflows, parts = parse(input)
    parts.filter do |part|
      current_workflow = workflows["in"]
      part_is_kept = false
      loop do
        res = current_workflow[part[:x], part[:m], part[:a], part[:s]]
        if res == "R" || res == "A"
          part_is_kept = res == "A"
          break
        end
        current_workflow = workflows[res]
      end
      part_is_kept
    end.sum { |part| part.values.sum }
  end

  def self.parse2(input)
    workflow_lines, _ = input.split("\n\n")
    workflow_lines.split("\n").to_h do |line|
      label = line[/^[a-z]+/]
      flow = line[/(?<={).*(?=})/].gsub(/([a-z]{2,}|[A-Z])/) { "'#{$&}'" }.gsub(":", " ? ").gsub(",", " : ").gsub(/(?<=:) [axm].*?\?.*?:.*/) { "(#{_1})" }
      [label, flow]
    end
  end

  def self.part2(input)
    workflows = parse2(input)
    accepted_ranges = []
    queue = [
      {
        args: {
          x: {start: 1, end: 4000},
          m: {start: 1, end: 4000},
          a: {start: 1, end: 4000},
          s: {start: 1, end: 4000}
        },
        workflow: workflows["in"]
      }
    ]
    while queue.any?
      current = queue.shift
      workflow = current[:workflow]
      cond, *branches = workflow.split("?")
      letter, op, n = cond[/[xmas]/].to_sym, cond[/[<>]/], cond[/\d+/].to_i
      branches = branches.join("?") if branches.instance_of?(Array)
      valid, *invalid = branches[/^[^:]*/], branches[/(?<=:).*/]
      invalid = invalid.join("?") if invalid.instance_of?(Array)
      if op == "<"
        if eval(valid) == "A"
          accepted_ranges << {letter: letter, start: current[:args][letter][:start], end: n - 1}
        elsif eval(valid) != "R"
          new_args = current[:args].dup
          new_args[letter] = {start: current[:args][letter][:start], end: n - 1}
          queue << {
            args: new_args,
            workflow: workflows[eval(valid)]
          }
        end

        if invalid[0] == "("
          new_args = current[:args].dup
          new_args[letter] = {start: n, end: current[:args][letter][:end]}
          queue << {
            args: new_args,
            workflow: invalid.tr("()", "")
          }
        elsif eval(invalid) == "A"
          accepted_ranges << {letter: letter, start: n, end: current[:args][letter][:end]}
        elsif eval(invalid) != "R"
          new_args = current[:args].dup
          new_args[letter] = {start: n, end: current[:args][letter][:end]}
          queue << {
            args: new_args,
            workflow: workflows[eval(invalid)]
          }
        end
      else
        if eval(valid) == "A"
          accepted_ranges << {letter: letter, start: n, end: current[:args][letter][:start]}
        elsif eval(valid) != "R"
          new_args = current[:args].dup
          new_args[letter] = {start: n, end: current[:args][letter][:start]}
          queue << {
            args: new_args,
            workflow: workflows[eval(valid)]
          }
        end

        if invalid[0] == "("
          new_args = current[:args].dup
          new_args[letter] = {start: current[:args][letter][:end], end: n - 1}
          queue << {
            args: new_args,
            workflow: invalid.tr("()", "")
          }
        elsif eval(invalid) == "A"
          accepted_ranges << {letter: letter, start: current[:args][letter][:end], end: n - 1}
        elsif eval(invalid) != "R"
          new_args = current[:args].dup
          new_args[letter] = {start: current[:args][letter][:end], end: n - 1}
          queue << {
            args: new_args,
            workflow: workflows[eval(invalid)]
          }
        end
      end
    end
    %i[x m a s].each do |l|
      p accepted_ranges.filter { |r| r[:letter] == l }.sort_by { _1[:start] }
    end
    accepted_ranges.map { |r| r[:end] - r[:start] }.reduce(:*)
  end
end
# standard:enable Security/Eval
