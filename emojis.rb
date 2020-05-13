require 'json'
require 'active_support/all'

EMOJI_DATA = JSON.load File.open("./emojis.json")

class Emojify
    def self.ForName(name) 
        name = name.downcase
        emoji = EMOJI_DATA[name] || EMOJI_DATA[name.singularize] || EMOJI_DATA[name.pluralize] || EMOJI_DATA[name.parameterize.underscore]
        if emoji != nil
            return emoji['char']
        end

        EMOJI_DATA.each do |emoji_name, val|
            if val["keywords"].include?(name) || val["keywords"].include?(name.singularize) || val["keywords"].include?(name.pluralize) 
                return val['char']
            end
        end

        return nil
    end

    def self.RandomEmojis(num)
        truly_random = EMOJI_DATA.values.filter{|val| !["flags", "symbols"].include? val["category"]}.sample(5).map {|val| val['char']}
        common = ['⌛','⌨','⏰','☎','☕','♀','⚽','⚾','⛰','⛳','⛴','⛺','✂','✈','✊','🌁','🌂','🌃','🌆','🌉','🌊','🌔','🌱','🌳','🌴','🌹','🌺','🌻','🌼','🌿','🍄','🍅','🍊','🍌','🍏','🍕','🍝','🍞','🍡','🍨','🍪','🍯','🍰','🍱','🍳','🍵','🍷','🍸','🍺','🍽','🍾','🎎','🎏','🎒','🎖','🎦','🎨','🎲','🎸','🎹','🎾','🎿','🏃','🏈','🏊','🏍','🏕','🏗','🏘','🏙','🏠','🏢','🏣','🏫','🏭','🏵','🏺','🐔','🐘','🐝','🐢','🐦','🐨','🐯','🐱','🐶','👄','👒','👓','👔','👕','👖','👗','👛','👜','👞','👟','👤','👥','👧','👨','👩','👫','👰','👱','👶','💄','💅','💆','💈','💒','💠','💡','💧','💺','💻','💼','📁','📕','📚','📱','📶','📷','🔣','🔥','🔪','🔫','🔭','🔼','🕴','🖨','🗼','😀','😄','😎','😺','🚀','🚋','🚌','🚕','🚗','🚘','🚚','🚪','🚲','🚽','🚿','🛀','🛁','🛋','🛏','🛣','🛩','🛫','🤖','🤠','🤢','🤣','🤲','🤳','🥄','🥎','🥕','🥚','🥛','🥦','🥾','🦎','🦐','🦑','🦒','🦓','🦞','🧑','🧒','🧗','🧢','🧤','🧥','🧱','🧳','🧵','🧶','🧸'].sample(num-5)
        Set.new(truly_random) | Set.new(common)
    end
end