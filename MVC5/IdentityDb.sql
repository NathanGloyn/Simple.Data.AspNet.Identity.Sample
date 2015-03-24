USE $(DBName)
GO

CREATE TABLE [dbo].[AspNetRoles](
	[Id] [nvarchar](128) NOT NULL,
	[Name] [nvarchar](256) NOT NULL
);

ALTER TABLE [dbo].[AspNetRoles]
	ADD CONSTRAINT [PK_dbo.AspNetRole] PRIMARY KEY CLUSTERED ([Id] ASC);


CREATE TABLE [dbo].[AspNetUserClaims](
	[Id] [int] IDENTITY(1,1) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL,
	[ClaimType] [nvarchar](max) NULL,
	[ClaimValue] [nvarchar](max) NULL
);

ALTER TABLE [dbo].[AspNetUserClaims]
	ADD CONSTRAINT [PK_dbo.AspNetUserClaims] PRIMARY KEY CLUSTERED ( [Id] ASC);


CREATE TABLE [dbo].[AspNetUserLogins](
	[LoginProvider] [nvarchar](128) NOT NULL,
	[ProviderKey] [nvarchar](128) NOT NULL,
	[UserId] [nvarchar](128) NOT NULL
);

ALTER TABLE [dbo].[AspNetUserLogins]
	ADD CONSTRAINT [PK_dbo.AspNetUserLogins] PRIMARY KEY CLUSTERED (
		[LoginProvider] ASC,
		[ProviderKey] ASC,
		[UserId] ASC
	);

CREATE TABLE [dbo].[AspNetUserRoles](
	[UserId] [nvarchar](128) NOT NULL,
	[RoleId] [nvarchar](128) NOT NULL
);

ALTER TABLE [dbo].[AspNetUserRoles]
	ADD CONSTRAINT [PK_dbo.AspNetUserRoles] PRIMARY KEY CLUSTERED (
		[UserId] ASC,
		[RoleId] ASC
	);

CREATE TABLE [dbo].[AspNetUsers](
	[Id] [nvarchar](128) NOT NULL,
	[Email] [nvarchar](256) NULL,
	[EmailConfirmed] [bit] NOT NULL,
	[PasswordHash] [nvarchar](max) NULL,
	[SecurityStamp] [nvarchar](max) NULL,
	[PhoneNumber] [nvarchar](max) NULL,
	[PhoneNumberConfirmed] [bit] NOT NULL,
	[TwoFactorEnabled] [bit] NOT NULL,
	[LockoutEndDateUtc] [datetime] NULL,
	[LockoutEnabled] [bit] NOT NULL,
	[AccessFailedCount] [int] NOT NULL,
	[UserName] [nvarchar](256) NOT NULL
);

ALTER TABLE [dbo].[AspNetUsers]
	ADD CONSTRAINT [PK_dbo.AspNetUsers] PRIMARY KEY CLUSTERED ([Id] ASC);

INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'537162F2-07F3-4FA4-95D0-D8A3436AAD86', N'Admin')
GO
INSERT [dbo].[AspNetRoles] ([Id], [Name]) VALUES (N'D656380A-D034-4CA0-96EE-0FAF7AD4D01D', N'User')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'28c0d8ab-9903-4ca4-b524-c0e84e2910cf', N'D656380A-D034-4CA0-96EE-0FAF7AD4D01D')
GO
INSERT [dbo].[AspNetUserRoles] ([UserId], [RoleId]) VALUES (N'aee1eaa7-b87f-45eb-a23c-086b4f74f8ed', N'537162F2-07F3-4FA4-95D0-D8A3436AAD86')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'28c0d8ab-9903-4ca4-b524-c0e84e2910cf', N'bob@test.com', 0, N'AH/DFaVoSmSX+48q4F8xPGDEyzqroffxVgL3Ip39jxGoqSSNHbJYxXJb36IIpZeP+g==', N'f916949f-d643-4ef1-9da3-cf1ea02e292e', NULL, 0, 0, CAST(0x0000A4630137072B AS DateTime), 1, 0, N'bob@test.com')
GO
INSERT [dbo].[AspNetUsers] ([Id], [Email], [EmailConfirmed], [PasswordHash], [SecurityStamp], [PhoneNumber], [PhoneNumberConfirmed], [TwoFactorEnabled], [LockoutEndDateUtc], [LockoutEnabled], [AccessFailedCount], [UserName]) VALUES (N'aee1eaa7-b87f-45eb-a23c-086b4f74f8ed', N'admin@test.com', 1, N'AHGnPi8AVOIJ+ibjdhUKl9h2yhfxPhQJcztAfBDOFsOilE3KrKqeW0O3IteXxcsB4w==', N'8e8a7ecc-d447-4f45-a44e-9bc50764d49b', NULL, 0, 0, NULL, 1, 1, N'admin@test.com')
GO
	
ALTER TABLE [dbo].[AspNetUserClaims]  WITH CHECK 
	ADD CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[AspNetUserClaims] CHECK CONSTRAINT [FK_dbo.AspNetUserClaims_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserLogins]  WITH CHECK 
	ADD  CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id]) ON DELETE CASCADE;

ALTER TABLE [dbo].[AspNetUserLogins] CHECK CONSTRAINT [FK_dbo.AspNetUserLogins_dbo.AspNetUsers_UserId];

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK 
	ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId] FOREIGN KEY([RoleId]) REFERENCES [dbo].[AspNetRoles] ([Id])	ON DELETE CASCADE;

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetRoles_RoleId];

ALTER TABLE [dbo].[AspNetUserRoles]  WITH CHECK 
	ADD  CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId] FOREIGN KEY([UserId]) REFERENCES [dbo].[AspNetUsers] ([Id])	ON DELETE CASCADE;

ALTER TABLE [dbo].[AspNetUserRoles] CHECK CONSTRAINT [FK_dbo.AspNetUserRoles_dbo.AspNetUsers_UserId];
GO
