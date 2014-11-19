namespace :import do
  desc "TODO"
  task brothers: :environment do
    file = Rails.root.join("app/assets/brothers.csv")
    lines = File.read(file).lines.select { |x| !x.strip.empty? }

    # Oops
    Brother.destroy_all

    lines.each do |l|
      name, year, pc, k = l.split(',')
      name.strip!
      year = year.to_i
      pc.strip!
      k.strip!

      if /@/ =~ k
        k = k[0...-8]
      end

      ppc = PledgeClass.find_by(name: pc)

      if ppc.nil?
        puts 'CANNOT FIND PLEDGE CLASS ' + pc
      end

      Brother.create({
        name: name,
        year: year,
        pledge_class_id: ppc.id,
        kerberos: k
      })

      puts 'Created ' + name
    end
  end
end
