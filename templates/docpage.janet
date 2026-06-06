(use mendoza/template-env)

(defn render-toc
  "渲染页面的目录。"
  [node]
  (def url (if (node :pages) (string (node :url) "/index.html") (node :url)))
  {:tag "li"
   "class" (if (node :pages) "caret")
   :content [{:tag "span" 
              "class" (if (= (dyn :url) url) "selected")
              :content {:tag "a" "href" (relative-url url) :content (or (node :nav-title) (node :title))}}
             (if-let [pages (node :pages)]
               {:tag "ul"
                :content (map render-toc pages)})]})

(var total-order nil)

(defn visit
  [node]
  (if-let [ps (node :pages)]
    (do 
      (if (node :index) (array/push total-order (node :index)))
      (each page ps (visit page)))
    (array/push total-order node)))

(defn get-total-order
  "惰性获取总顺序。必须惰性求值，因为站点地图在所有模板解析完成之前尚未构建。"
  []
  (unless total-order
    (set total-order @[])
    (visit (dyn :sitemap)))
  total-order)

(defn findrel
  "在总顺序中根据 URL 查找页面的偏移量。"
  [url offset]
  (def order (get-total-order))
  (def len (length order))
  (def my-index (find-index (fn [x] (= url (x :url))) order))
  (def index (% (+ my-index len offset) len))
  (order index))

(defn find-old-versions
  "获取本文档的旧版本，用于链接目的。"
  []
  (sort (seq [d :in (os/dir "static")
              :let [m (peg/match ~'(* (/ ':d+ ,scan-number) "." (/ ':d+ ,scan-number) "." (/ ':d+ ,scan-number)) d)]
              :when m
              :when (not= d janet/version)]
          (tuple ;m)) >))

(def other-versions (map last (find-old-versions)))
