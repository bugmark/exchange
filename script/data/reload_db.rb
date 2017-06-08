def pmsg(string)   ; puts "\n----- #{string}"       ; end
def sql_mode       ; ARGV[0] == 'sql'               ; end
def build_mode     ; ARGV[0] == 'build'             ; end
def clean_mode     ; ARGV[0] == 'clean'             ; end

def devlog(*args)
  dev_log(*args)
end

def mode
  case ARGV[0]
    when 'build', 'clean' then ARGV[0]
    else 'overwrite'
  end
end

def reload_db(executable)

  pmsg "running #{executable} (mode = #{mode})"

  if build_mode || sql_mode
    pmsg 'drop the old database'
    system 'bundle exec rake db:drop'
    pmsg 'create a new database'
    system 'bundle exec rake db:create'
  end

  if build_mode
    pmsg 'run migrations'
    system 'bundle exec rake db:migrate'
  end

  if sql_mode
    pmsg 'recreating database'
    system 'bundle exec rake db:structure:load'
  end

  pmsg 'loading rails'
  require __dir__ + '/../config/environment'

  if clean_mode
    pmsg 'cleaning database'
    Org.all.each  {|item| item.destroy}
    User.all.each {|item| item.destroy}
  end

end
