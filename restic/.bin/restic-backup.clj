(require '[clojure.java.shell :refer [sh]]
         '[clojure.tools.cli :refer [parse-opts]])

(def cli-options
  [["-r" "--repo REPO" "Restic repo"
    :default "/home/joshmock/.restic"]])

(def repo (:repo (:options (parse-opts *command-line-args* cli-options))))

(defn backup [location]
  (println (:out (str "Indexing " location "\n")))
  (sh "restic" "-r" repo "--verbose" "backup" location)
  (println (:out (str "Pruning " location "\n")))
  (sh "restic" "-r" repo "--verbose" "prune"
      "--keep-daily" "7"
      "--keep-weekly" "5"
      "--keep-monthly" "12"
      "--keep-yearly" "20"))

(def backups ["/home/joshmock/Desktop"
              "/home/joshmock/.gnupg"
              "/home/joshmock/dotfiles"
              "/home/joshmock/.zsh_history"
              "/home/joshmock/.gmailctl"])

(map backup backups)
