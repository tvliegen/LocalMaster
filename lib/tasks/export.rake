namespace :export do
  
  task :seeds_format => :environment do
    Portalmanager::Appdef.order(:id).all.each do |data|
      puts "Portalmanager::Appdef.create(#{data.serializable_hash.delete_if {|key, value| ['created_at','updated_at','id'].include?(key)}.to_s.gsub(/[{}]/,'')})"
    end
  end
end                        
