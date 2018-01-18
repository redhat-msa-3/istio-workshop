We can experiment with Istio routing rules by making a change to RecommendationsController.java like

## recommendations:v2

We can experiment with Istio routing rules by making a change to RecommendationsController.java like

<pre class="file" data-filename="/root/istio-tutorial/recommendations/src/main/java/com/example/recommendations/RecommendationsController.java">
    System.out.println("Big Red Dog v2 " + cnt);
     
    return "Clifford v2 " + cnt;
</pre>
