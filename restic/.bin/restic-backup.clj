(require '[clojure.java.shell :refer [sh]])

(defn backup [[bup-name location]]
  (sh "bup" "index" location)
  (sh "bup" "save" "-n" (name bup-name) location))

(def backups {:desktop "/home/joshmock/Desktop"
              :gpg "/home/joshmock/.gnupg"
              :dotfiles "/home/joshmock/dotfiles"
              :etc "/etc"
              :zsh-history "/home/joshmock/.zsh_history"})

(map backup backups)
