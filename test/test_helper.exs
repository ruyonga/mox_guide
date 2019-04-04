ExUnit.start()
Ecto.Adapters.SQL.Sandbox.mode(MoxGuide.Repo, :manual)
Mox.defmock(MoxGuideWeb.UserServiceMock, for: MoxGuideWeb.UserServiceBehaviour)
