## Mixer

`Mixer` is a platform-independent component responsible for enforcing access control and usage policies across the service mesh and collecting telemetry data from the Envoy proxy and other services. The proxy extracts request level attributes, which are sent to Mixer for evaluation. More information on this attribute extraction and policy evaluation can be found in Mixer Configuration. Mixer includes a flexible plugin model enabling it to interface with a variety of host environments and infrastructure backends, abstracting the Envoy proxy and Istio-managed services from these details.



## Pilot

`Pilot` provides service discovery for the Envoy sidecars, traffic management capabilities for intelligent routing (e.g., A/B tests, canary deployments, etc.), and resiliency (timeouts, retries, circuit breakers, etc.). It converts a high level routing rules that control traffic behavior into Envoy-specific configurations, and propagates them to the sidecars at runtime. Pilot abstracts platform-specifc service discovery mechanisms and synthesizes them into a standard format consumable by any sidecar that conforms to the Envoy data plane APIs. This loose coupling allows Istio to run on multiple environments (e.g., Kubernetes, Consul/Nomad) while maintaining the same operator interface for traffic management.



## Proxy/Sidecar