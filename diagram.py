from diagrams import Diagram
from diagrams.aws.network import Route53HostedZone

with Diagram("AWS Route53 Zone", show=False, direction="TB"):
    Route53HostedZone("Public/Private Zone")
